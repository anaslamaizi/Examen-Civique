import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../features/results/results_screen.dart';
import '../../widgets/answer_card.dart';
import '../../models/quiz_models.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(body: Center(child: Text('Aucune question disponible.')));
    }
    final selected = state.answers[question.id]?.selected;
    final progress = (state.currentIndex + 1) / state.activeQuiz.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${state.currentIndex + 1} / ${state.activeQuiz.length}'),
        actions: [
          IconButton(
            onPressed: () => state.toggleFavorite(question.id),
            icon: Icon(state.favoriteIds.contains(question.id) ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 16),
            Text(question.question, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ...question.options.entries.map(
              (entry) => AnswerCard(
                label: entry.key,
                text: entry.value,
                selected: selected == entry.key,
                state: state.mode == QuizMode.instant && selected != null
                    ? entry.key == question.correctAnswer
                        ? true
                        : selected == entry.key
                            ? false
                            : null
                    : null,
                onTap: selected != null
                    ? () {}
                    : () {
                        state.submitAnswer(entry.key);
                        if (state.mode == QuizMode.instant) {
                          _showInstantFeedback(context, question.correctAnswer, question.explanation);
                        }
                      },
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: selected == null
                  ? null
                  : () {
                      if (state.currentIndex == state.activeQuiz.length - 1) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultsScreen()));
                      } else {
                        state.nextQuestion();
                      }
                    },
              child: const Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstantFeedback(BuildContext context, String correctAnswer, String explanation) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bonne réponse : $correctAnswer', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(explanation),
          ],
        ),
      ),
    );
  }
}
