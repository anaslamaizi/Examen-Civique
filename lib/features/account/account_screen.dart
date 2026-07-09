import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../data/purchase_service.dart';
import '../premium/paywall_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final PurchaseService _purchaseService = PurchaseService();
  bool _restoring = false;

  Future<void> _restorePurchases() async {
    setState(() => _restoring = true);
    final result = await _purchaseService.restorePurchases();
    if (!mounted) return;
    setState(() => _restoring = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
  }

  Future<void> _copySupportEmail() async {
    const email = 'support@test-civique.online';
    await Clipboard.setData(const ClipboardData(text: email));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email support copié : support@test-civique.online')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final status = state.premiumStatus;

    return Scaffold(
      appBar: AppBar(title: const Text('Mon compte')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            _SectionCard(
              label: 'Profil',
              title: 'Compte local',
              children: const [
                _InfoRow(
                  icon: Icons.mail_outline_rounded,
                  title: 'Email',
                  subtitle: 'À synchroniser avec le backend web',
                ),
                _InfoRow(
                  icon: Icons.flag_rounded,
                  title: 'Objectif',
                  subtitle: 'Carte de résident / Naturalisation',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              label: 'Mon offre',
              title: status.isActive ? 'Premium actif' : 'Offre gratuite',
              children: [
                _PremiumStatusCard(
                  isPremium: status.isActive,
                  plan: status.plan,
                  source: status.sourceLabel,
                  until: status.premiumUntilLabel,
                ),
                if (!status.isActive) ...[
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaywallScreen()),
                    ),
                    icon: const Icon(Icons.workspace_premium_rounded),
                    label: const Text('Passer Premium'),
                  ),
                ],
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _restoring ? null : _restorePurchases,
                  icon: _restoring
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.restore_rounded),
                  label: const Text('Restaurer mes achats'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              label: 'Usage',
              title: 'Préparation',
              children: [
                _InfoRow(
                  icon: Icons.quiz_rounded,
                  title: state.dailyQuizLabel,
                  subtitle: status.isActive ? 'Aucune limite Premium' : '${state.remainingFreeQuizzes} quiz gratuit restant aujourd’hui',
                ),
                _InfoRow(
                  icon: Icons.menu_book_rounded,
                  title: '${state.readRevisionIds.length} fiche(s) lue(s)',
                  subtitle: '${state.favoriteRevisionIds.length} fiche(s) favorite(s)',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              label: 'Support',
              title: 'Besoin d’aide ?',
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const _IconBox(icon: Icons.help_outline_rounded),
                  title: const Text('Aide et support', style: TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: const Text('Copier l’email de contact'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: _copySupportEmail,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.label, required this.title, required this.children});

  final String label;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontSize: 12,
                letterSpacing: 3,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _PremiumStatusCard extends StatelessWidget {
  const _PremiumStatusCard({required this.isPremium, required this.plan, required this.source, required this.until});

  final bool isPremium;
  final String plan;
  final String source;
  final String until;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isPremium ? const Color(0xFFEFFDF5) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isPremium ? const Color(0xFFBBF7D0) : const Color(0xFFD9E3F2)),
      ),
      child: Row(
        children: [
          _IconBox(icon: isPremium ? Icons.verified_rounded : Icons.lock_open_rounded),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'Premium' : 'Gratuit',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  isPremium ? 'Plan $plan • Source $source • Jusqu’au $until' : '1 quiz gratuit par jour et thèmes limités',
                  style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (isPremium)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(999)),
              child: const Text('Actif', style: TextStyle(color: Color(0xFF15803D), fontWeight: FontWeight.w900)),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          _IconBox(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF0F172A))),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: const Color(0xFF1D4ED8)),
    );
  }
}
