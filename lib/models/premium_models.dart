enum SubscriptionSource { none, web, android }

class PremiumStatus {
  const PremiumStatus({
    required this.isPremium,
    required this.premiumUntil,
    required this.plan,
    required this.subscriptionSource,
  });

  factory PremiumStatus.free() {
    return const PremiumStatus(
      isPremium: false,
      premiumUntil: null,
      plan: 'free',
      subscriptionSource: SubscriptionSource.none,
    );
  }

  final bool isPremium;
  final DateTime? premiumUntil;
  final String plan;
  final SubscriptionSource subscriptionSource;

  bool get isActive {
    if (!isPremium) return false;
    if (premiumUntil == null) return true;
    return premiumUntil!.isAfter(DateTime.now());
  }

  String get sourceLabel {
    switch (subscriptionSource) {
      case SubscriptionSource.web:
        return 'Web';
      case SubscriptionSource.android:
        return 'Android';
      case SubscriptionSource.none:
        return 'Aucune';
    }
  }

  String get premiumUntilLabel {
    final value = premiumUntil;
    if (value == null) return 'Illimité';
    return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  PremiumStatus copyWith({
    bool? isPremium,
    DateTime? premiumUntil,
    String? plan,
    SubscriptionSource? subscriptionSource,
  }) {
    return PremiumStatus(
      isPremium: isPremium ?? this.isPremium,
      premiumUntil: premiumUntil ?? this.premiumUntil,
      plan: plan ?? this.plan,
      subscriptionSource: subscriptionSource ?? this.subscriptionSource,
    );
  }
}

SubscriptionSource subscriptionSourceFromName(String value) {
  return SubscriptionSource.values.firstWhere(
    (source) => source.name == value,
    orElse: () => SubscriptionSource.none,
  );
}
