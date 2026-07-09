import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../mistakes/mistakes_screen.dart';
import '../premium/paywall_screen.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('$correct / $total', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text('$percent % de réussite'),
                    Text('Bonnes réponses: $correct • Mauvaises réponses: $wrong'),
                    const SizedBox(height: 8),
                    Text(percent >= 70 ? 'Excellent, continuez !' : 'Bon début, refaites un tour pour progresser.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Refaire'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                if (!state.isPremium) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MistakesScreen()));
              },
              icon: Icon(state.isPremium ? Icons.history_rounded : Icons.lock_rounded),
              label: Text(state.isPremium ? 'Revoir mes erreurs' : 'Revoir mes erreurs • Premium'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Retour accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
