class Question {
  const Question({
    required this.id,
    required this.section,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.draft,
  });

  final String id;
  final String section;
  final String question;
  final Map<String, String> options;
  final String correctAnswer;
  final String explanation;
  final bool draft;

  Question copyWith({
    String? id,
    String? section,
    String? question,
    Map<String, String>? options,
    String? correctAnswer,
    String? explanation,
    bool? draft,
  }) {
    return Question(
      id: id ?? this.id,
      section: section ?? this.section,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      draft: draft ?? this.draft,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      section: json['section'] as String,
      question: json['question'] as String,
      options: Map<String, String>.from(json['options'] as Map),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      draft: json['draft'] as bool? ?? false,
    );
  }
}
