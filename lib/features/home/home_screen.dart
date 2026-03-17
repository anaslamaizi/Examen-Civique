import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../features/mistakes/mistakes_screen.dart';
import '../../features/quiz/quiz_screen.dart';
import '../../features/revision/revision_screen.dart';
import '../../features/theme_selection/theme_selection_screen.dart';
import '../../models/quiz_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Examen Civique FR')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Préparez-vous efficacement à l’examen civique français',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '${state.allQuestions.length} questions • Offline • Correction instantanée ou finale',
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                state.startQuiz(mode: QuizMode.instant);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
              },
              child: const Text('Commencer'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()),
              ),
              child: const Text('Réviser par thème'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                state.startQuiz(mode: QuizMode.finalCorrection, full: true);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
              },
              child: const Text('Test complet'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RevisionScreen()),
              ),
              child: const Text('Flashcards'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MistakesScreen()),
              ),
              child: const Text('Erreurs & favoris'),
            ),
          ],
        ),
      ),
    );
  }
}
