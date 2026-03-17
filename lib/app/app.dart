import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/home/home_screen.dart';
import 'app_state.dart';

class ExamenCiviqueApp extends StatelessWidget {
  const ExamenCiviqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Civique FR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: Consumer<AppState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return const HomeScreen();
        },
      ),
    );
  }
}
