import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_state.dart';
import 'data/questions_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState(QuestionsRepository());
  await appState.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const ExamenCiviqueApp(),
    ),
  );
}
