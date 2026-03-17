import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/questions_repository.dart';
import '../models/question.dart';
import '../models/quiz_models.dart';

class AppState extends ChangeNotifier {
  AppState(this._repository);

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
      ..addAll(prefs.getStringList('favorites') ?? []);
    _mistakeIds
      ..clear()
      ..addAll(prefs.getStringList('mistakes') ?? []);
    _loading = false;
    notifyListeners();
  }

  void startQuiz({String? section, required QuizMode mode, bool full = false}) {
    _mode = mode;
    _answers.clear();
    _currentIndex = 0;
    final source = section == null ? _allQuestions : _allQuestions.where((q) => q.section == section).toList();
    _activeQuiz = List<Question>.from(source);
    _activeQuiz.shuffle(_random);
    if (!full && _activeQuiz.length > 20) {
      _activeQuiz = _activeQuiz.take(20).toList();
    }
    notifyListeners();
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

  bool get isQuizFinished => _activeQuiz.isNotEmpty && _answers.length == _activeQuiz.length;

  int get correctCount => _answers.values.where((answer) => answer.isCorrect).length;

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
}
