import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:examen_civique_fr/app/app_state.dart';
import 'package:examen_civique_fr/data/question_metadata.dart';
import 'package:examen_civique_fr/data/questions_repository.dart';
import 'package:examen_civique_fr/models/question.dart';
import 'package:examen_civique_fr/models/quiz_models.dart';

class FakeQuestionsRepository extends QuestionsRepository {
  FakeQuestionsRepository(this._questions);

  final List<Question> _questions;

  @override
  Future<List<Question>> loadQuestions() async => _questions;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
      'full quiz always contains 40 questions with balanced themes when possible',
      () async {
    final state = AppState(
      FakeQuestionsRepository(_buildQuestions(perSection: 10)),
    );

    await state.initialize();
    state.startQuiz(mode: QuizMode.finalCorrection, full: true);

    expect(state.activeQuiz, hasLength(40));

    for (final section in officialQuizSections) {
      final count = state.activeQuiz
          .where((question) => question.section == section)
          .length;
      expect(count, 8);
    }
  });

  test('theme revision includes all questions from the selected theme',
      () async {
    final state = AppState(
      FakeQuestionsRepository(_buildQuestions(perSection: 12)),
    );

    await state.initialize();
    state.startQuiz(
      section: principlesAndValuesSection,
      mode: QuizMode.instant,
    );

    expect(state.activeQuiz, hasLength(12));
    expect(
      state.activeQuiz.every(
        (question) => question.section == principlesAndValuesSection,
      ),
      isTrue,
    );
  });

  test('legacy favorite and mistake ids are migrated to official ids',
      () async {
    SharedPreferences.setMockInitialValues({
      'favorites': ['pri_102'],
      'mistakes': ['sys_102'],
    });

    final state = AppState(
      FakeQuestionsRepository(_buildQuestionsWithLegacyTargets(perSection: 10)),
    );

    await state.initialize();

    expect(state.favoriteIds, contains('pri_037'));
    expect(state.favoriteIds, isNot(contains('pri_102')));
    expect(state.mistakeIds, contains('sys_034'));
    expect(state.mistakeIds, isNot(contains('sys_102')));
  });

  test('restarting a full quiz produces a different attempt', () async {
    final state = AppState(
      FakeQuestionsRepository(_buildQuestions(perSection: 10)),
    );

    await state.initialize();
    state.startQuiz(mode: QuizMode.finalCorrection, full: true);
    final firstAttempt =
        state.activeQuiz.map((question) => question.id).toList();

    state.restartQuiz();
    final secondAttempt =
        state.activeQuiz.map((question) => question.id).toList();

    expect(secondAttempt, hasLength(40));
    expect(secondAttempt, isNot(equals(firstAttempt)));
  });
}

List<Question> _buildQuestions({required int perSection}) {
  final questions = <Question>[];

  for (final section in officialQuizSections) {
    for (var index = 0; index < perSection; index++) {
      questions.add(
        Question(
          id: '${_sectionPrefix(section)}_${index.toString().padLeft(3, '0')}',
          section: section,
          question: '$section question $index',
          options: const {
            'A': 'Bonne réponse',
            'B': 'Option 2',
            'C': 'Option 3',
            'D': 'Option 4',
          },
          correctAnswer: 'A',
          explanation: 'Explication courte.',
          draft: false,
        ),
      );
    }
  }

  return questions;
}

List<Question> _buildQuestionsWithLegacyTargets({required int perSection}) {
  final questions = _buildQuestions(perSection: perSection);

  questions.add(
    const Question(
      id: 'pri_037',
      section: principlesAndValuesSection,
      question: 'Une personne a-t-elle le droit de ne pas croire ?',
      options: {
        'A': 'Oui',
        'B': 'Non',
        'C': 'Seulement à 18 ans',
        'D': 'Seulement en privé',
      },
      correctAnswer: 'A',
      explanation: 'Oui, liberté de conscience.',
      draft: false,
    ),
  );

  questions.add(
    const Question(
      id: 'sys_034',
      section: institutionsSection,
      question: 'Qui dirige la commune ?',
      options: {
        'A': 'Le maire',
        'B': 'Le préfet',
        'C': 'Le juge',
        'D': 'Le député',
      },
      correctAnswer: 'A',
      explanation: 'La commune est dirigée par le maire.',
      draft: false,
    ),
  );

  return questions;
}

String _sectionPrefix(String section) {
  switch (section) {
    case principlesAndValuesSection:
      return 'pri';
    case institutionsSection:
      return 'sys';
    case rightsAndDutiesSection:
      return 'dro';
    case historyGeographyCultureSection:
      return 'his';
    case societySection:
      return 'viv';
  }

  return 'q';
}
