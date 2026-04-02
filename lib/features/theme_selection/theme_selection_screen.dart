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
    final sections = state.allQuestions.map((q) => q.section).toSet().toList()..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Réviser par thème')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final section = sections[index];
          final count = state.allQuestions.where((q) => q.section == section).length;
          final icon = _iconForSection(section);
          final tint = _colorForIndex(index);

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              leading: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: tint),
              ),
              title: Text(
                section,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '$count questions',
                  style: const TextStyle(color: Color(0xFF475569)),
                ),
              ),
              trailing: Icon(Icons.chevron_right_rounded, color: tint),
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

IconData _iconForSection(String section) {
  final value = section.toLowerCase();

  if (value.contains('histoire') || value.contains('france')) {
    return Icons.account_balance_rounded;
  }
  if (value.contains('valeur') || value.contains('république') || value.contains('republique')) {
    return Icons.flag_rounded;
  }
  if (value.contains('droit') || value.contains('devoir')) {
    return Icons.gavel_rounded;
  }
  if (value.contains('citoyen') || value.contains('administr')) {
    return Icons.apartment_rounded;
  }
  if (value.contains('langue') || value.contains('culture')) {
    return Icons.menu_book_rounded;
  }
  return Icons.category_rounded;
}

Color _colorForIndex(int index) {
  const colors = [
    Color(0xFF1D4ED8),
    Color(0xFF0F766E),
    Color(0xFF7C3AED),
    Color(0xFFDC2626),
    Color(0xFFC2410C),
  ];

  return colors[index % colors.length];
}
