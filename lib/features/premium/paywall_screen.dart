import 'package:flutter/material.dart';

import '../../data/purchase_service.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final PurchaseService _purchaseService = PurchaseService();
  bool _loading = false;

  Future<void> _buyPremium() async {
    setState(() => _loading = true);
    final result = await _purchaseService.buyPremium();
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Préparation complète',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Débloquez votre préparation complète',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      height: 1.08,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Quiz illimités, tous les thèmes, examens blancs et révisions avancées dans une seule app.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: const [
                    _BenefitTile(icon: Icons.all_inclusive_rounded, label: 'Quiz illimités'),
                    _BenefitTile(icon: Icons.category_rounded, label: 'Tous les thèmes'),
                    _BenefitTile(icon: Icons.menu_book_rounded, label: 'Fiches de révision complètes'),
                    _BenefitTile(icon: Icons.fact_check_rounded, label: 'Examens blancs'),
                    _BenefitTile(icon: Icons.history_rounded, label: 'Revoir mes erreurs'),
                    _BenefitTile(icon: Icons.trending_up_rounded, label: 'Points faibles'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _loading ? null : _buyPremium,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.workspace_premium_rounded),
              label: const Text('Passer Premium'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continuer gratuitement'),
            ),
            const SizedBox(height: 12),
            Text(
              'Paiement Android : couche Google Play Billing préparée. Il reste à connecter les produits Play Console et la validation serveur.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A)),
        ],
      ),
    );
  }
}
