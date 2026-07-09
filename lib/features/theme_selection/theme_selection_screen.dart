import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/quiz_models.dart';
import '../premium/paywall_screen.dart';
import '../quiz/quiz_screen.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final sections = state.sections;

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
          final locked = !state.isPremium && state.isPremiumSection(section);

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
                child: Icon(locked ? Icons.lock_rounded : icon, color: tint),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      section,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  if (locked)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Premium',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFFC2410C)),
                      ),
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  locked ? '$count questions • débloqué avec Premium' : '$count questions',
                  style: const TextStyle(color: Color(0xFF475569)),
                ),
              ),
              trailing: Icon(Icons.chevron_right_rounded, color: locked ? const Color(0xFFC2410C) : tint),
              onTap: () {
                final started = context.read<AppState>().startQuiz(section: section, mode: QuizMode.instant);
                if (!started) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                  return;
                }
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
