class PurchaseService {
  static const premiumMonthlyProductId = 'premium_monthly';
  static const premiumSevenDaysProductId = 'premium_7_days';

  Future<PurchaseResult> buyPremium() async {
    return const PurchaseResult(
      success: false,
      message: 'Google Play Billing est préparé mais pas encore connecté.',
    );
  }

  Future<PurchaseResult> restorePurchases() async {
    return const PurchaseResult(
      success: false,
      message: 'Aucun achat Android restauré pour le moment.',
    );
  }
}

class PurchaseResult {
  const PurchaseResult({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}
