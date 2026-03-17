import 'question.dart';

enum QuizMode { instant, finalCorrection }

class QuizAnswer {
  const QuizAnswer({required this.question, required this.selected});

  final Question question;
  final String selected;

  bool get isCorrect => selected == question.correctAnswer;
}
