import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
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
    final state = context.watch<ScoreboardState>();

    return MaterialApp(
      title: 'Scoreboard',
      debugShowCheckedModeBanner: false,
      locale: Locale(state.locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF222222),
      ),
      home: const ScoreboardScreen(),
    );
  }
}
