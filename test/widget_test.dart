import 'package:flutter_test/flutter_test.dart';
import 'package:korisviritys/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const BasketballScoreboardApp());
    expect(find.text('JAKSO'), findsOneWidget);
  });
}
