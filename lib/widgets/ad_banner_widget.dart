import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobIds {
  static const _androidTestBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _androidReleaseBanner =
      'ca-app-pub-6481673949788169/6728295142';

  static bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static bool get _isIos =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static bool get canInitialize => _isAndroid;

  static String? get bannerAdUnitId {
    if (_isAndroid) {
      return kReleaseMode ? _androidReleaseBanner : _androidTestBanner;
    }

    if (_isIos) {
      return null;
    }

    return null;
  }
}

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final adUnitId = AdMobIds.bannerAdUnitId;
    if (adUnitId == null) return;

    final bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerAd = _bannerAd;
    if (!_isLoaded || bannerAd == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: bannerAd.size.height.toDouble() + 12,
          child: Center(
            child: SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            ),
          ),
        ),
      ),
    );
  }
}
