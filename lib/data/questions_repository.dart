import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question.dart';

class QuestionsRepository {
  Future<List<Question>> loadQuestions() async {
    final raw = await rootBundle.loadString('assets/data/examen_civique_questions.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Question.fromJson(item as Map<String, dynamic>))
        .where((question) => !question.draft)
        .toList();
  }

  Future<List<Question>> loadAllIncludingDrafts() async {
    final raw = await rootBundle.loadString('assets/data/examen_civique_questions.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.map((item) => Question.fromJson(item as Map<String, dynamic>)).toList();
  }
}
