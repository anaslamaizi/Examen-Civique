import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../widgets/ad_banner_widget.dart';
import '../mistakes/mistakes_screen.dart';
import '../quiz/quiz_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final total = state.activeQuiz.length;
    final correct = state.correctCount;
    final wrong = total - correct;
    final percent = total == 0 ? 0 : ((correct / total) * 100).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Résultats')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '$correct / $total',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('$percent % de réussite'),
                          Text(
                              'Bonnes réponses : $correct • Mauvaises réponses : $wrong'),
                          const SizedBox(height: 8),
                          Text(
                            percent >= 70
                                ? 'Excellent, continuez !'
                                : 'Bon début, refaites un tour pour progresser.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      state.restartQuiz();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const QuizScreen()),
                      );
                    },
                    child: const Text('Refaire'),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MistakesScreen()),
                    ),
                    child: const Text('Revoir mes erreurs'),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    child: const Text('Retour accueil'),
                  ),
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
