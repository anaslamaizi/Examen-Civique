import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' hide AppState;
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_state.dart';
import 'data/questions_repository.dart';
import 'widgets/ad_banner_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AdMobIds.canInitialize) {
    await MobileAds.instance.initialize();
  }

  final appState = AppState(QuestionsRepository());
  await appState.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const ExamenCiviqueApp(),
    ),
  );
}
