import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../features/results/results_screen.dart';
import '../../widgets/ad_banner_widget.dart';
import '../../widgets/answer_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(
          body: Center(child: Text('Aucune question disponible.')));
    }

    final answer = state.answers[question.id];
    final selected = answer?.selected;
    final progress = (state.currentIndex + 1) / state.activeQuiz.length;
    final hasAnswered = selected != null;
    final isLastQuestion = state.currentIndex == state.activeQuiz.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('${state.currentIndex + 1} / ${state.activeQuiz.length}'),
        actions: [
          IconButton(
            onPressed: () => state.toggleFavorite(question.id),
            icon: Icon(
              state.favoriteIds.contains(question.id)
                  ? Icons.star
                  : Icons.star_border,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 16),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...question.options.entries.map(
                    (entry) => AnswerCard(
                      label: entry.key,
                      text: entry.value,
                      selected: selected == entry.key,
                      state: hasAnswered
                          ? entry.key == question.correctAnswer
                              ? true
                              : selected == entry.key
                                  ? false
                                  : null
                          : null,
                      statusLabel: _statusLabelForOption(
                        option: entry.key,
                        selected: selected,
                        correctAnswer: question.correctAnswer,
                      ),
                      onTap: hasAnswered
                          ? () {}
                          : () => state.submitAnswer(entry.key),
                    ),
                  ),
                  if (hasAnswered) ...[
                    const SizedBox(height: 16),
                    _QuizFeedbackCard(
                      selectedAnswer: selected,
                      selectedAnswerText: question.options[selected] ?? '',
                      correctAnswer: question.correctAnswer,
                      correctAnswerText:
                          question.options[question.correctAnswer] ?? '',
                      explanation: question.explanation,
                      isCorrect: answer?.isCorrect ?? false,
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: !hasAnswered
                        ? null
                        : () {
                            if (isLastQuestion) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ResultsScreen()),
                              );
                            } else {
                              state.nextQuestion();
                            }
                          },
                    child:
                        Text(isLastQuestion ? 'Voir le résultat' : 'Suivant'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}

String? _statusLabelForOption({
  required String option,
  required String? selected,
  required String correctAnswer,
}) {
  if (selected == null) return null;
  if (option == correctAnswer) return 'Bonne réponse';
  if (option == selected) return 'Votre choix';
  return null;
}

class _QuizFeedbackCard extends StatelessWidget {
  const _QuizFeedbackCard({
    required this.selectedAnswer,
    required this.selectedAnswerText,
    required this.correctAnswer,
    required this.correctAnswerText,
    required this.explanation,
    required this.isCorrect,
  });

  final String selectedAnswer;
  final String selectedAnswerText;
  final String correctAnswer;
  final String correctAnswerText;
  final String explanation;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isCorrect ? const Color(0xFF16A34A) : const Color(0xFFDC2626);
    final backgroundColor =
        isCorrect ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2);
    final icon = isCorrect ? Icons.check_circle_rounded : Icons.info_rounded;
    final title = isCorrect ? 'Bonne réponse' : 'Correction affichée';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: borderColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: borderColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Votre réponse : $selectedAnswer - $selectedAnswerText',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Bonne réponse : $correctAnswer - $correctAnswerText',
            style: const TextStyle(color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),
          Text(
            explanation,
            style: const TextStyle(
              color: Color(0xFF334155),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
