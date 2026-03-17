import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/quiz_models.dart';
import '../quiz/quiz_screen.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final sections = state.allQuestions.map((q) => q.section).toSet().toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Réviser par thème')),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(section),
              subtitle: Text('${state.allQuestions.where((q) => q.section == section).length} questions'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                state.startQuiz(section: section, mode: QuizMode.instant);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
              },
            ),
          );
        },
      ),
    );
  }
}
