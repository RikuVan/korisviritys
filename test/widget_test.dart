import 'package:flutter_test/flutter_test.dart';
import 'package:koris_viritys/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const BasketballScoreboardApp());
    expect(find.text('JAKSO'), findsOneWidget);
  });
}
