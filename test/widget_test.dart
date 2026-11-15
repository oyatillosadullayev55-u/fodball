import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/data/mock_data.dart';
import 'package:fodball/game3d/match_painter.dart';
import 'package:fodball/main.dart';
import 'package:fodball/screens/match_screen.dart';
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

  testWidgets('Home hech qachon scroll qilmaydi, faqat tugma bilan o\'tiladi',
      (tester) async {
    await _pumpAt(tester, const Size(360, 780));
    expect(find.byType(Scrollable), findsNothing);

    await tester.tap(find.text('Start Match'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(MatchScreen), findsOneWidget);
  });

  testWidgets('Match ko\'rinishi har kadrda yangilanadi va o\'yinchilar yuradi',
      (tester) async {
    tester.view.physicalSize = const Size(800, 360);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      GameStateScope(
        state: GameState(),
        child: MaterialApp(home: MatchScreen(match: MockData.nextMatch)),
      ),
    );

    MatchPainter currentPainter() => tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((c) => c.painter)
        .whereType<MatchPainter>()
        .single;

    await tester.pump(const Duration(milliseconds: 16));
    final first = currentPainter();
    final before = [for (final p in first.game.players) p.pos];
    final startTime = first.game.time;

    for (var i = 0; i < 150; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    final second = currentPainter();
    // Painter har kadrda yangi bo'ladi — 3D sahna muzlab qolmaydi.
    expect(identical(first, second), isFalse);
    expect(second.game.time, greaterThan(startTime));
    expect(
      [
        for (var i = 0; i < before.length; i++)
          (second.game.players[i].pos - before[i]).length > 0.5,
      ].any((moved) => moved),
      isTrue,
    );
  });
}
