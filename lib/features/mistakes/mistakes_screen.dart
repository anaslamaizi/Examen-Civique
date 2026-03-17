import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';

class MistakesScreen extends StatelessWidget {
  const MistakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = state.allQuestions
        .where((q) => state.mistakeIds.contains(q.id) || state.favoriteIds.contains(q.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Erreurs & favoris')),
      body: items.isEmpty
          ? const Center(child: Text('Aucune erreur ou favori pour le moment.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final q = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(q.question),
                    subtitle: Text('Réponse: ${q.correctAnswer} - ${q.options[q.correctAnswer]}'),
                    trailing: IconButton(
                      icon: Icon(
                        state.favoriteIds.contains(q.id) ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => state.toggleFavorite(q.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
