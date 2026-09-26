import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:korisviritys/main.dart';
import 'package:korisviritys/state/scoreboard_state.dart';

void main() {
  setUp(() {
    // ScoreboardState persists through SharedPreferences on every change.
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('App renders', (WidgetTester tester) async {
    final state = ScoreboardState();
    addTearDown(state.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider<ScoreboardState>.value(value: state)],
        child: const BasketballScoreboardApp(),
      ),
    );
    // Localization delegates resolve asynchronously; let them settle.
    await tester.pumpAndSettle();

    // Default locale is English, so the period label renders as "PERIOD".
    expect(find.text('PERIOD  '), findsOneWidget);
  });
}
