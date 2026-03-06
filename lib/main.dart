import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/scoreboard_state.dart';
import 'widgets/scoreboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ScoreboardState())],
      child: const BasketballScoreboardApp(),
    ),
  );
}

class BasketballScoreboardApp extends StatelessWidget {
  const BasketballScoreboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtuaalinen Koripallotulostaulu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF222222),
      ),
      home: const ScoreboardScreen(),
    );
  }
}
