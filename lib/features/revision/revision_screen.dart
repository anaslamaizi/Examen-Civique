import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  int index = 0;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    final questions = context.watch<AppState>().allQuestions;
    if (questions.isEmpty) return const Scaffold(body: Center(child: Text('Aucune donnée.')));
    final q = questions[index % questions.length];

    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(q.question, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    if (showAnswer)
                      Text('Réponse: ${q.correctAnswer} — ${q.options[q.correctAnswer]}\n${q.explanation}'),
                  ],
                ),
              ),
            ),
            FilledButton(
              onPressed: () => setState(() => showAnswer = !showAnswer),
              child: Text(showAnswer ? 'Masquer' : 'Voir réponse'),
            ),
            OutlinedButton(
              onPressed: () => setState(() {
                index += 1;
                showAnswer = false;
              }),
              child: const Text('Carte suivante'),
            ),
          ],
        ),
      ),
    );
  }
}
