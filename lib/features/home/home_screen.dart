import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../features/account/account_screen.dart';
import '../../features/mistakes/mistakes_screen.dart';
import '../../features/premium/paywall_screen.dart';
import '../../features/quiz/quiz_screen.dart';
import '../../features/revision/revision_screen.dart';
import '../../features/theme_selection/theme_selection_screen.dart';
import '../../models/quiz_models.dart';

const _appLogoAsset = 'assets/icon.png';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen Civique FR'),
        actions: [
          IconButton(
            tooltip: 'Mon compte',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountScreen()),
            ),
            icon: const Icon(Icons.account_circle_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: _AppMark(size: 34),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            _HeroCard(questionCount: state.allQuestions.length),
            const SizedBox(height: 16),
            _PremiumSummaryCard(state: state),
            const SizedBox(height: 18),
            _ActionTile(
              label: 'Quiz aléatoire',
              subtitle: state.isPremium ? 'Quiz illimités de tous les thèmes' : '${state.remainingFreeQuizzes} quiz gratuit restant aujourd’hui',
              icon: Icons.psychology_rounded,
              tint: const Color(0xFF1D4ED8),
              onTap: () => _startQuiz(context),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              label: 'Créer mon quiz',
              subtitle: 'Choisir thème, difficulté et nombre de questions',
              icon: Icons.tune_rounded,
              tint: const Color(0xFF7C3AED),
              premium: !state.isPremium,
              onTap: () => _premiumOr(context, premiumOnly: true, action: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()));
              }),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              label: 'Réviser par thème',
              subtitle: 'Thèmes gratuits + thèmes Premium verrouillés',
              icon: Icons.category_rounded,
              tint: const Color(0xFF0F766E),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              label: 'Fiches de révision',
              subtitle: 'Recherche, filtres, favoris et fiches détaillées',
              icon: Icons.menu_book_rounded,
              tint: const Color(0xFF2563EB),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RevisionScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              label: 'Examens blancs',
              subtitle: 'Mode complet avec correction finale',
              icon: Icons.fact_check_rounded,
              tint: const Color(0xFFC2410C),
              premium: !state.isPremium,
              onTap: () => _premiumOr(context, premiumOnly: true, action: () {
                _startQuiz(context, full: true, mode: QuizMode.finalCorrection, premiumOnly: true);
              }),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              label: 'Revoir mes erreurs',
              subtitle: 'Questions ratées et favoris',
              icon: Icons.history_rounded,
              tint: const Color(0xFFDC2626),
              premium: !state.isPremium,
              onTap: () => _premiumOr(context, premiumOnly: true, action: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MistakesScreen()));
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuiz(
    BuildContext context, {
    QuizMode mode = QuizMode.instant,
    bool full = false,
    bool premiumOnly = false,
  }) {
    final state = context.read<AppState>();
    final started = state.startQuiz(mode: mode, full: full, premiumOnly: premiumOnly);
    if (!started) {
      _openPaywall(context);
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
  }

  void _premiumOr(BuildContext context, {required bool premiumOnly, required VoidCallback action}) {
    final state = context.read<AppState>();
    if (premiumOnly && !state.isPremium) {
      _openPaywall(context);
      return;
    }
    action();
  }

  void _openPaywall(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.questionCount});

  final int questionCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F3D91), Color(0xFF1D4ED8), Color(0xFFF7FAFF)],
          stops: [0, 0.62, 1],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A1D4ED8),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _AppMark(size: 58),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Préparez votre examen civique',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.06,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Quiz, QCM, fiches et examens blancs. Gratuit pour commencer, Premium pour accélérer.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroChip(icon: Icons.quiz_rounded, label: '$questionCount questions'),
              const _HeroChip(icon: Icons.cloud_off_rounded, label: 'Offline'),
              const _HeroChip(icon: Icons.workspace_premium_rounded, label: 'Premium prêt'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PremiumSummaryCard extends StatelessWidget {
  const _PremiumSummaryCard({required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final isPremium = state.isPremium;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD9E3F2)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isPremium ? const Color(0xFFDCFCE7) : const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isPremium ? Icons.verified_rounded : Icons.lock_open_rounded,
              color: isPremium ? const Color(0xFF15803D) : const Color(0xFF1D4ED8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'Premium actif' : 'Mode gratuit',
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  isPremium ? 'Tous les thèmes et quiz illimités.' : '${state.dailyQuizLabel} • ${state.freeSections.length} thèmes gratuits',
                  style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (!isPremium)
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen())),
              child: const Text('Premium'),
            ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.tint,
    required this.onTap,
    this.premium = false,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final Color tint;
  final VoidCallback onTap;
  final bool premium;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.11),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: tint),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
              ),
            ),
            if (premium)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(999)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_rounded, size: 13, color: Color(0xFFC2410C)),
                    SizedBox(width: 3),
                    Text('Premium', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFFC2410C))),
                  ],
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: premium ? const Color(0xFFC2410C) : tint),
        onTap: onTap,
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _AppMark extends StatelessWidget {
  const _AppMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.24),
      child: Image.asset(
        _appLogoAsset,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF0F3D91),
            borderRadius: BorderRadius.circular(size * 0.24),
          ),
          child: Icon(Icons.menu_book_rounded, color: Colors.white, size: size * 0.5),
        ),
      ),
    );
  }
}
