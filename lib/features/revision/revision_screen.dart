import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../data/revision_fiches.dart';
import '../../models/quiz_models.dart';
import '../../models/revision_fiche.dart';
import '../premium/paywall_screen.dart';
import '../quiz/quiz_screen.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  String _query = '';
  String _theme = 'Toutes';
  String _status = 'Toutes';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final themes = ['Toutes', ...revisionFiches.map((fiche) => fiche.theme).toSet()];
    final filtered = revisionFiches.where((fiche) {
      final text = '${fiche.title} ${fiche.theme} ${fiche.subtitle} ${fiche.summary}'.toLowerCase();
      final matchesQuery = _query.trim().isEmpty || text.contains(_query.trim().toLowerCase());
      final matchesTheme = _theme == 'Toutes' || fiche.theme == _theme;
      final isRead = state.readRevisionIds.contains(fiche.slug);
      final isFavorite = state.favoriteRevisionIds.contains(fiche.slug);
      final matchesStatus = switch (_status) {
        'À lire' => !isRead,
        'Lues' => isRead,
        'Favoris' => isFavorite,
        _ => true,
      };
      return matchesQuery && matchesTheme && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiches de révision'),
        actions: [
          TextButton.icon(
            onPressed: () {
              final started = context.read<AppState>().startQuiz(mode: QuizMode.instant);
              if (!started) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                return;
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
            },
            icon: const Icon(Icons.psychology_rounded),
            label: const Text('Quiz'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Text(
              'Renforcez vos connaissances entre les quiz • ${state.readRevisionIds.length}/${revisionFiches.length} lues',
              style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une fiche, un sujet, un point clé...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xFFD9E3F2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xFFD9E3F2)),
                ),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 14),
            _FilterPanel(
              themes: themes,
              selectedTheme: _theme,
              selectedStatus: _status,
              onThemeChanged: (value) => setState(() => _theme = value),
              onStatusChanged: (value) => setState(() => _status = value),
            ),
            const SizedBox(height: 14),
            if (filtered.isEmpty)
              const _EmptyState()
            else
              ...filtered.map((fiche) => _FicheTile(fiche: fiche)).expand((widget) => [widget, const SizedBox(height: 10)]),
          ],
        ),
      ),
    );
  }
}

class RevisionDetailScreen extends StatelessWidget {
  const RevisionDetailScreen({super.key, required this.fiche});

  final RevisionFiche fiche;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isRead = state.readRevisionIds.contains(fiche.slug);
    final isFavorite = state.favoriteRevisionIds.contains(fiche.slug);

    return Scaffold(
      appBar: AppBar(title: const Text('Fiche de révision')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _DetailHeader(fiche: fiche),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.read<AppState>().toggleRevisionRead(fiche.slug),
                    icon: Icon(isRead ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded),
                    label: Text(isRead ? 'Lu' : 'Marquer comme lu'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.read<AppState>().toggleRevisionFavorite(fiche.slug),
                    icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                    label: Text(isFavorite ? 'Favori' : 'Favoris'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _KeyPointsCard(points: fiche.keyPoints),
            const SizedBox(height: 12),
            ...fiche.sections.map((section) => _ContentCard(section: section)).expand((widget) => [widget, const SizedBox(height: 12)]),
            _PitfallsCard(items: fiche.pitfalls),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _startKnowledgeQuiz(context, fiche),
              icon: const Icon(Icons.psychology_rounded),
              label: Text('Tester mes connaissances (${fiche.questionCount} questions)'),
            ),
          ],
        ),
      ),
    );
  }

  void _startKnowledgeQuiz(BuildContext context, RevisionFiche fiche) {
    final state = context.read<AppState>();
    state.markRevisionRead(fiche.slug);
    final section = _matchingQuestionSection(state, fiche.theme);
    final started = state.startQuiz(section: section, mode: QuizMode.instant);
    if (!started) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
  }

  String? _matchingQuestionSection(AppState state, String theme) {
    final normalizedTheme = _normalize(theme);
    for (final section in state.sections) {
      final normalizedSection = _normalize(section);
      if (normalizedSection.contains(normalizedTheme) || normalizedTheme.contains(normalizedSection)) {
        return section;
      }
    }
    return null;
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('&', ' ')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('à', 'a')
        .replaceAll('ç', 'c')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim();
  }
}

class _FilterPanel extends StatelessWidget {
  const _FilterPanel({
    required this.themes,
    required this.selectedTheme,
    required this.selectedStatus,
    required this.onThemeChanged,
    required this.onStatusChanged,
  });

  final List<String> themes;
  final String selectedTheme;
  final String selectedStatus;
  final ValueChanged<String> onThemeChanged;
  final ValueChanged<String> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    const statuses = ['Toutes', 'À lire', 'Lues', 'Favoris'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.filter_alt_outlined, size: 18, color: Color(0xFF1D4ED8)),
                SizedBox(width: 6),
                Text('Filtres', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final theme in themes)
                  ChoiceChip(
                    label: Text(theme),
                    selected: selectedTheme == theme,
                    onSelected: (_) => onThemeChanged(theme),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final status in statuses)
                  ChoiceChip(
                    label: Text(status),
                    selected: selectedStatus == status,
                    onSelected: (_) => onStatusChanged(status),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FicheTile extends StatelessWidget {
  const _FicheTile({required this.fiche});

  final RevisionFiche fiche;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isRead = state.readRevisionIds.contains(fiche.slug);
    final isFavorite = state.favoriteRevisionIds.contains(fiche.slug);
    final locked = fiche.isPremium && !state.isPremium;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        leading: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => context.read<AppState>().toggleRevisionRead(fiche.slug),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isRead ? const Color(0xFF1D4ED8) : const Color(0xFFCBD5E1), width: 2),
              color: isRead ? const Color(0xFFE8F0FF) : Colors.white,
            ),
            child: isRead ? const Icon(Icons.check_rounded, color: Color(0xFF1D4ED8), size: 20) : null,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_themeIcon(fiche.theme), size: 14, color: const Color(0xFF64748B)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    fiche.theme,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                  ),
                ),
                if (locked)
                  const Icon(Icons.lock_rounded, size: 16, color: Color(0xFFC2410C))
                else if (isFavorite)
                  const Icon(Icons.favorite_rounded, size: 16, color: Color(0xFFDC2626)),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              fiche.title,
              style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            locked ? '${fiche.subtitle} • Premium' : fiche.subtitle,
            style: const TextStyle(color: Color(0xFF64748B)),
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: locked ? const Color(0xFFC2410C) : const Color(0xFF64748B)),
        onTap: () {
          if (locked) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (_) => RevisionDetailScreen(fiche: fiche)));
        },
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.fiche});

  final RevisionFiche fiche;

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
          colors: [Color(0xFF0F3D91), Color(0xFF1D4ED8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_themeIcon(fiche.theme), color: Colors.white.withValues(alpha: 0.9), size: 18),
              const SizedBox(width: 8),
              Text(
                fiche.theme.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            fiche.title,
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1.05),
          ),
          const SizedBox(height: 10),
          Text(
            fiche.subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: 0.9), height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _KeyPointsCard extends StatelessWidget {
  const _KeyPointsCard({required this.points});

  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return _BoxCard(
      background: const Color(0xFFE8F0FF),
      border: const Color(0xFFCAD8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, size: 18, color: Color(0xFF1D4ED8)),
              SizedBox(width: 6),
              Text('À retenir', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1D4ED8))),
            ],
          ),
          const SizedBox(height: 10),
          ...points.map((point) => _Bullet(text: point)),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.section});

  final RevisionContentSection section;

  @override
  Widget build(BuildContext context) {
    return _BoxCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
          const SizedBox(height: 10),
          ...section.items.map((item) => _Bullet(text: item)),
        ],
      ),
    );
  }
}

class _PitfallsCard extends StatelessWidget {
  const _PitfallsCard({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return _BoxCard(
      background: const Color(0xFFFFF1F2),
      border: const Color(0xFFFECACA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, size: 18, color: Color(0xFFDC2626)),
              SizedBox(width: 6),
              Text('Pièges fréquents', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFDC2626))),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((item) => _Bullet(text: item, color: const Color(0xFFDC2626))),
        ],
      ),
    );
  }
}

class _BoxCard extends StatelessWidget {
  const _BoxCard({required this.child, this.background = Colors.white, this.border = const Color(0xFFD9E3F2)});

  final Widget child;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: child,
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, this.color = const Color(0xFF1D4ED8)});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Icon(Icons.circle, size: 6, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35, color: Color(0xFF0F172A)))),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text('Aucune fiche trouvée.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w700)),
      ),
    );
  }
}

IconData _themeIcon(String theme) {
  final value = theme.toLowerCase();
  if (value.contains('institution')) return Icons.account_balance_rounded;
  if (value.contains('droit')) return Icons.gavel_rounded;
  if (value.contains('vie')) return Icons.home_work_rounded;
  return Icons.flag_rounded;
}
