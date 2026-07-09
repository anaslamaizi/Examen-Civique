import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/question_metadata.dart';
import '../data/questions_repository.dart';
import '../models/question.dart';
import '../models/quiz_models.dart';

class AppState extends ChangeNotifier {
  AppState(this._repository);

  static const Map<String, String> _legacyQuestionIdAliases = {
    'pri_102': 'pri_037',
    'pri_103': 'pri_034',
    'sys_102': 'sys_034',
  };

  final QuestionsRepository _repository;
  final Random _random = Random();

  List<Question> _allQuestions = [];
  List<Question> _activeQuiz = [];
  final Map<String, QuizAnswer> _answers = {};
  final Set<String> _favoriteIds = {};
  final Set<String> _mistakeIds = {};

  int _currentIndex = 0;
  bool _loading = true;
  QuizMode _mode = QuizMode.instant;
  String? _activeSection;
  bool _isFullQuiz = false;
  List<String> _lastFullQuizIds = const [];

  bool get isLoading => _loading;
  List<Question> get allQuestions => _allQuestions;
  List<Question> get activeQuiz => _activeQuiz;
  int get currentIndex => _currentIndex;
  QuizMode get mode => _mode;
  Set<String> get favoriteIds => _favoriteIds;
  Set<String> get mistakeIds => _mistakeIds;

  Question? get currentQuestion =>
      _currentIndex < _activeQuiz.length ? _activeQuiz[_currentIndex] : null;

  Map<String, QuizAnswer> get answers => _answers;

  Future<void> initialize() async {
    _loading = true;
    notifyListeners();
    _allQuestions = await _repository.loadQuestions();
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds
      ..clear()
      ..addAll(_normalizePersistedIds(prefs.getStringList('favorites') ?? []));
    _mistakeIds
      ..clear()
      ..addAll(_normalizePersistedIds(prefs.getStringList('mistakes') ?? []));
    await _persistSets();
    _loading = false;
    notifyListeners();
  }

  void startQuiz({String? section, required QuizMode mode, bool full = false}) {
    _mode = mode;
    _activeSection = section;
    _isFullQuiz = full;
    _answers.clear();
    _currentIndex = 0;
    final source = section == null
        ? _allQuestions
        : _allQuestions
            .where((question) => question.section == section)
            .toList();

    if (full) {
      _activeQuiz = _buildFullQuiz(_allQuestions);
    } else {
      _activeQuiz = List<Question>.from(source);
      _activeQuiz.shuffle(_random);
      if (section == null && _activeQuiz.length > quickQuizQuestionCount) {
        _activeQuiz = _activeQuiz.take(quickQuizQuestionCount).toList();
      }
    }
    notifyListeners();
  }

  void restartQuiz() {
    if (_allQuestions.isEmpty) return;
    startQuiz(section: _activeSection, mode: _mode, full: _isFullQuiz);
  }

  void submitAnswer(String option) {
    final question = currentQuestion;
    if (question == null) return;
    _answers[question.id] = QuizAnswer(question: question, selected: option);
    if (option != question.correctAnswer) {
      _mistakeIds.add(question.id);
      _persistSets();
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _activeQuiz.length - 1) {
      _currentIndex += 1;
      notifyListeners();
    }
  }

  bool get isQuizFinished =>
      _activeQuiz.isNotEmpty && _answers.length == _activeQuiz.length;

  int get correctCount =>
      _answers.values.where((answer) => answer.isCorrect).length;

  void toggleFavorite(String questionId) {
    if (_favoriteIds.contains(questionId)) {
      _favoriteIds.remove(questionId);
    } else {
      _favoriteIds.add(questionId);
    }
    _persistSets();
    notifyListeners();
  }

  Future<void> _persistSets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteIds.toList());
    await prefs.setStringList('mistakes', _mistakeIds.toList());
  }

  List<Question> _buildFullQuiz(List<Question> source) {
    if (source.length <= fullQuizQuestionCount) {
      final quiz = List<Question>.from(source)..shuffle(_random);
      _rememberFullQuiz(quiz);
      return quiz;
    }

    var quiz = _buildFullQuizOnce(source);

    if (_hasSameFullQuizAsLast(quiz)) {
      for (var attempt = 0;
          attempt < 6 && _hasSameFullQuizAsLast(quiz);
          attempt++) {
        quiz = _buildFullQuizOnce(source);
      }
    }

    if (_hasSameFullQuizAsLast(quiz) && quiz.length > 1) {
      quiz = [...quiz.skip(1), quiz.first];
    }

    _rememberFullQuiz(quiz);
    return quiz;
  }

  List<Question> _buildFullQuizOnce(List<Question> source) {
    final selected = <Question>[];
    final usedIds = <String>{};
    final questionsPerSection =
        fullQuizQuestionCount ~/ officialQuizSections.length;

    // Guarantee the 5 official themes are represented before filling the rest.
    for (final section in officialQuizSections) {
      final sectionQuestions = source
          .where((question) => question.section == section)
          .toList()
        ..shuffle(_random);
      final sectionSelection = sectionQuestions.take(questionsPerSection);
      for (final question in sectionSelection) {
        selected.add(question);
        usedIds.add(question.id);
      }
    }

    if (selected.length < fullQuizQuestionCount) {
      final remaining = source
          .where((question) => !usedIds.contains(question.id))
          .toList()
        ..shuffle(_random);
      selected.addAll(remaining.take(fullQuizQuestionCount - selected.length));
    }

    selected.shuffle(_random);
    return selected.take(fullQuizQuestionCount).toList();
  }

  List<String> _normalizePersistedIds(List<String> ids) {
    return ids.map((id) => _legacyQuestionIdAliases[id] ?? id).toSet().toList();
  }

  bool _hasSameFullQuizAsLast(List<Question> quiz) {
    final ids = quiz.map((question) => question.id).toList();
    return listEquals(ids, _lastFullQuizIds);
  }

  void _rememberFullQuiz(List<Question> quiz) {
    _lastFullQuizIds = quiz.map((question) => question.id).toList();
  }
}
