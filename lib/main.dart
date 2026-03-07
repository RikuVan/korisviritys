import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/scoreboard_state.dart';
import 'widgets/scoreboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final state = ScoreboardState();
  state.restore();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: state)],
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
