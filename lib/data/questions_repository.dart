import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question.dart';
import 'draft_question_completions.dart';
import 'supplemental_questions.dart';

class QuestionsRepository {
  Future<List<Question>> loadQuestions() async {
    final questions = await _loadMergedQuestions();
    return questions.where((question) => !question.draft).toList();
  }

  Future<List<Question>> loadAllIncludingDrafts() async {
    return _loadMergedQuestions();
  }

  Future<List<Question>> _loadMergedQuestions() async {
    final raw = await rootBundle
        .loadString('assets/data/examen_civique_questions.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    final baseQuestions = decoded
        .map((item) => Question.fromJson(item as Map<String, dynamic>))
        .map(_applyCompletion)
        .toList();
    final merged = <String, Question>{
      for (final question in baseQuestions) question.id: question,
      for (final question in supplementalQuestions) question.id: question,
    };
    return merged.values.toList();
  }

  Question _applyCompletion(Question question) {
    final completion = draftQuestionCompletions[question.id];
    if (completion == null) {
      return question;
    }

    return question.copyWith(
      options: completion.options,
      correctAnswer: completion.correctAnswer,
      explanation: completion.explanation,
      draft: false,
    );
  }
}
