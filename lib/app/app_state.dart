import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/questions_repository.dart';
import '../models/premium_models.dart';
import '../models/question.dart';
import '../models/quiz_models.dart';

class AppState extends ChangeNotifier {
  AppState(this._repository);

  static const int freeDailyQuizLimit = 1;
  static const int freeSectionCount = 2;

  final QuestionsRepository _repository;
  final Random _random = Random();

  List<Question> _allQuestions = [];
  List<Question> _activeQuiz = [];
  final Map<String, QuizAnswer> _answers = {};
  final Set<String> _favoriteIds = {};
  final Set<String> _mistakeIds = {};
  final Set<String> _readRevisionIds = {};
  final Set<String> _favoriteRevisionIds = {};

  int _currentIndex = 0;
  int _dailyQuizCount = 0;
  String _dailyQuizDate = '';
  bool _loading = true;
  QuizMode _mode = QuizMode.instant;
  PremiumStatus _premiumStatus = PremiumStatus.free();

  bool get isLoading => _loading;
  List<Question> get allQuestions => _allQuestions;
  List<Question> get activeQuiz => _activeQuiz;
  int get currentIndex => _currentIndex;
  QuizMode get mode => _mode;
  Set<String> get favoriteIds => _favoriteIds;
  Set<String> get mistakeIds => _mistakeIds;
  Set<String> get readRevisionIds => _readRevisionIds;
  Set<String> get favoriteRevisionIds => _favoriteRevisionIds;
  PremiumStatus get premiumStatus => _premiumStatus;
  bool get isPremium => _premiumStatus.isActive;
  int get dailyQuizCount => _dailyQuizCount;
  int get remainingFreeQuizzes => isPremium ? 999 : max(0, freeDailyQuizLimit - _dailyQuizCount);
  bool get canStartFreeQuizToday => isPremium || _dailyQuizCount < freeDailyQuizLimit;
  String get dailyQuizLabel => isPremium ? 'Quiz illimités' : '$_dailyQuizCount/$freeDailyQuizLimit quiz aujourd’hui';

  List<String> get sections {
    final values = _allQuestions.map((q) => q.section).toSet().toList()..sort();
    return values;
  }

  List<String> get freeSections => sections.take(freeSectionCount).toList();

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
    _readRevisionIds
      ..clear()
      ..addAll(prefs.getStringList('revision_read') ?? []);
    _favoriteRevisionIds
      ..clear()
      ..addAll(prefs.getStringList('revision_favorites') ?? []);
    _loadPremiumStatus(prefs);
    _loadDailyQuota(prefs);
    _loading = false;
    notifyListeners();
  }

  bool canAccessSection(String? section) {
    if (isPremium || section == null) return true;
    return freeSections.contains(section);
  }

  bool isPremiumSection(String section) => !freeSections.contains(section);

  bool canOpenPremiumContent({String? section, bool premiumOnly = false}) {
    if (isPremium) return true;
    if (premiumOnly) return false;
    return canAccessSection(section);
  }

  bool startQuiz({String? section, required QuizMode mode, bool full = false, bool premiumOnly = false}) {
    final source = section == null ? _allQuestions : _allQuestions.where((q) => q.section == section).toList();
    if (source.isEmpty) return false;
    if (!canOpenPremiumContent(section: section, premiumOnly: premiumOnly)) return false;
    if (!isPremium && !canStartFreeQuizToday) return false;

    _mode = mode;
    _answers.clear();
    _currentIndex = 0;
    _activeQuiz = List<Question>.from(source)..shuffle(_random);
    if (!full && _activeQuiz.length > 20) {
      _activeQuiz = _activeQuiz.take(20).toList();
    }
    if (!isPremium) {
      _dailyQuizCount += 1;
      _persistDailyQuota();
    }
    notifyListeners();
    return true;
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

  void toggleRevisionRead(String slug) {
    if (_readRevisionIds.contains(slug)) {
      _readRevisionIds.remove(slug);
    } else {
      _readRevisionIds.add(slug);
    }
    _persistRevisionSets();
    notifyListeners();
  }

  void markRevisionRead(String slug) {
    if (_readRevisionIds.add(slug)) {
      _persistRevisionSets();
      notifyListeners();
    }
  }

  void toggleRevisionFavorite(String slug) {
    if (_favoriteRevisionIds.contains(slug)) {
      _favoriteRevisionIds.remove(slug);
    } else {
      _favoriteRevisionIds.add(slug);
    }
    _persistRevisionSets();
    notifyListeners();
  }

  Future<void> applyPremiumStatus(PremiumStatus status) async {
    _premiumStatus = status;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('premium_is_active', status.isPremium);
    await prefs.setString('premium_plan', status.plan);
    await prefs.setString('premium_source', status.subscriptionSource.name);
    if (status.premiumUntil == null) {
      await prefs.remove('premium_until');
    } else {
      await prefs.setString('premium_until', status.premiumUntil!.toIso8601String());
    }
    notifyListeners();
  }

  Future<void> syncPremiumFromBackend({
    required bool isPremium,
    DateTime? premiumUntil,
    String plan = 'premium',
    SubscriptionSource subscriptionSource = SubscriptionSource.web,
  }) async {
    await applyPremiumStatus(
      PremiumStatus(
        isPremium: isPremium,
        premiumUntil: premiumUntil,
        plan: isPremium ? plan : 'free',
        subscriptionSource: isPremium ? subscriptionSource : SubscriptionSource.none,
      ),
    );
  }

  void _loadPremiumStatus(SharedPreferences prefs) {
    final isPremium = prefs.getBool('premium_is_active') ?? false;
    final premiumUntilRaw = prefs.getString('premium_until');
    final premiumUntil = premiumUntilRaw == null ? null : DateTime.tryParse(premiumUntilRaw);
    final plan = prefs.getString('premium_plan') ?? (isPremium ? 'premium' : 'free');
    final source = subscriptionSourceFromName(prefs.getString('premium_source') ?? SubscriptionSource.none.name);
    _premiumStatus = PremiumStatus(
      isPremium: isPremium,
      premiumUntil: premiumUntil,
      plan: plan,
      subscriptionSource: source,
    );
  }

  void _loadDailyQuota(SharedPreferences prefs) {
    final today = _todayKey();
    _dailyQuizDate = prefs.getString('daily_quiz_date') ?? today;
    _dailyQuizCount = prefs.getInt('daily_quiz_count') ?? 0;
    if (_dailyQuizDate != today) {
      _dailyQuizDate = today;
      _dailyQuizCount = 0;
      _persistDailyQuota();
    }
  }

  Future<void> _persistSets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteIds.toList());
    await prefs.setStringList('mistakes', _mistakeIds.toList());
  }

  Future<void> _persistRevisionSets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('revision_read', _readRevisionIds.toList());
    await prefs.setStringList('revision_favorites', _favoriteRevisionIds.toList());
  }

  Future<void> _persistDailyQuota() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('daily_quiz_date', _dailyQuizDate);
    await prefs.setInt('daily_quiz_count', _dailyQuizCount);
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}
