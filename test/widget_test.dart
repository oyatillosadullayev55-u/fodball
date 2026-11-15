import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/main.dart';
import 'package:fodball/state/game_state.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(FodballApp(state: GameState()));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Home ekrani asosiy bo\'limlarni chizadi', (tester) async {
    await _pumpAt(tester, const Size(1600, 1000));

    expect(find.text('FOOTBALL'), findsOneWidget);
    expect(find.text('Career Mode'), findsOneWidget);
    expect(find.text('Next Match'), findsOneWidget);
    expect(find.text('League Standings'), findsOneWidget);
    expect(find.text('Start Match'), findsOneWidget);
    expect(find.text('Real Madrid'), findsWidgets);
    expect(find.text('Barcelona'), findsWidgets);
  });

  for (final size in const [
    Size(1920, 1080),
    Size(1440, 900),
    Size(1180, 820),
    Size(900, 900),
    Size(768, 1024),
    Size(760, 360),
    Size(414, 896),
    Size(360, 780),
  ]) {
    testWidgets('Home ekranida overflow yo\'q: ${size.width.toInt()}x${size.height.toInt()}',
        (tester) async {
      await _pumpAt(tester, size);
      expect(tester.takeException(), isNull);
    });
  }
}
