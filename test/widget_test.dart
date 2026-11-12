import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/main.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const FodballApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Dashboard renders the main sections', (tester) async {
    await _pumpAt(tester, const Size(1600, 1000));

    expect(find.text('CHAMPIONS!'), findsOneWidget);
    expect(find.text('MY TEAM'), findsOneWidget);
    expect(find.text('Shoot'), findsOneWidget);
    expect(find.text('STORE'), findsWidgets);
  });

  for (final size in const [
    Size(1920, 1080),
    Size(1440, 900),
    Size(1180, 820),
    Size(900, 900),
    Size(768, 1024),
    Size(414, 896),
    Size(360, 780),
  ]) {
    testWidgets('No overflow at ${size.width.toInt()}x${size.height.toInt()}',
        (tester) async {
      await _pumpAt(tester, size);
      expect(tester.takeException(), isNull);
    });
  }
}
