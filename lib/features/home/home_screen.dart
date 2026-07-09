import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../data/question_metadata.dart';
import '../../features/mistakes/mistakes_screen.dart';
import '../../features/quiz/quiz_screen.dart';
import '../../features/revision/revision_screen.dart';
import '../../features/theme_selection/theme_selection_screen.dart';
import '../../models/quiz_models.dart';
import '../../widgets/ad_banner_widget.dart';

const _appLogoAsset = 'assets/icon.png';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen Civique FR'),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: _AppMark(size: 34),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            opacity: _visible ? 1 : 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              offset: _visible ? Offset.zero : const Offset(0, 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCard(questionCount: state.allQuestions.length),
                  const SizedBox(height: 18),
                  _InfoCard(questionCount: state.allQuestions.length),
                  const SizedBox(height: 22),
                  _PrimaryActionButton(
                    label: 'Commencer',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () {
                      state.startQuiz(mode: QuizMode.instant);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const QuizScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _SecondaryActionButton(
                    label: 'Réviser par thème',
                    icon: Icons.category_rounded,
                    tint: theme.colorScheme.primary,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ThemeSelectionScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SecondaryActionButton(
                    label: 'Test complet',
                    icon: Icons.fact_check_rounded,
                    trailing:
                        const _CountPill(label: '$fullQuizQuestionCount Q'),
                    tint: const Color(0xFF0F766E),
                    onPressed: () {
                      state.startQuiz(
                          mode: QuizMode.finalCorrection, full: true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const QuizScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _SecondaryActionButton(
                    label: 'Flashcards',
                    icon: Icons.auto_stories_rounded,
                    tint: const Color(0xFF7C3AED),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RevisionScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SecondaryActionButton(
                    label: 'Erreurs & favoris',
                    icon: Icons.bookmark_rounded,
                    trailing: const _DualStatusIcon(),
                    tint: const Color(0xFFC2410C),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MistakesScreen()),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFD7E3F4)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Mode sérieux, offline et rapide. Idéal pour des captures Play Store propres et rassurantes.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.questionCount});

  final int questionCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F3D91), Color(0xFF1D4ED8), Color(0xFFF7FAFF)],
          stops: [0, 0.58, 1],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A1D4ED8),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(top: 22, right: 28, child: _FrenchCockade()),
          Positioned(
            left: -16,
            bottom: -26,
            child: Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AppMark(size: 64),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Examen Civique FR',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Révisez avec une expérience claire, mobile-first et pensée pour réussir sereinement.',
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
                          const _HeroChip(
                            icon: Icons.shield_rounded,
                            label: 'Sérieux',
                          ),
                          _HeroChip(
                            icon: Icons.menu_book_rounded,
                            label: '$questionCount questions',
                          ),
                          const _HeroChip(
                            icon: Icons.check_circle_rounded,
                            label: 'Prêt à réviser',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.questionCount});

  final int questionCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD9E3F2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Préparation rapide',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tout l’essentiel pour vous entraîner efficacement, même sans connexion.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF475569),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoBadge(
                icon: Icons.quiz_rounded,
                label: '$questionCount questions',
                color: const Color(0xFFE8F0FF),
                iconColor: const Color(0xFF1D4ED8),
              ),
              const _InfoBadge(
                icon: Icons.cloud_off_rounded,
                label: 'Offline',
                color: Color(0xFFF1F5F9),
                iconColor: Color(0xFF334155),
              ),
              const _InfoBadge(
                icon: Icons.fact_check_rounded,
                label: 'Test complet : 40 questions',
                color: Color(0xFFE6FFFB),
                iconColor: Color(0xFF0F766E),
              ),
              const _InfoBadge(
                icon: Icons.bolt_rounded,
                label: 'Correction après chaque réponse',
                color: Color(0xFFFFE9E7),
                iconColor: Color(0xFFDC2626),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(label),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.tint,
    this.trailing,
  });

  final String label;
  final IconData icon;
  final Widget? trailing;
  final Color tint;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 64,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          side: BorderSide(color: tint.withValues(alpha: 0.18)),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: tint),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: tint,
                ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE6FFFB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0F766E),
          fontWeight: FontWeight.w800,
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
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
    final radius = BorderRadius.circular(size * 0.28);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F0F3D91),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        _appLogoAsset,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _DualStatusIcon extends StatelessWidget {
  const _DualStatusIcon();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 42,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 6,
            child: Icon(
              Icons.error_outline_rounded,
              size: 20,
              color: Color(0xFFEA580C),
            ),
          ),
          Positioned(
            right: 0,
            child: Icon(
              Icons.favorite_rounded,
              size: 20,
              color: Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}

class _FrenchCockade extends StatelessWidget {
  const _FrenchCockade();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF1D4ED8),
                  Color(0xFFF8FAFC),
                  Color(0xFFDC2626),
                  Color(0xFF1D4ED8),
                ],
              ),
            ),
          ),
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Color(0xFF0F3D91),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              size: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
