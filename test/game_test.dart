import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/game3d/penalty_game.dart';
import 'package:fodball/game3d/vec3.dart';
import 'package:fodball/main.dart';

void main() {
  const landscape = Size(716, 320);

  test('3D kamera darvozani ekranga to\'g\'ri joylashtiradi', () {
    final game = PenaltyGame();
    final proj = game.projectorFor(landscape);

    final topLeft = proj.project(
      const V3(-PenaltyGame.goalHalfWidth, PenaltyGame.goalHeight, 0),
    )!;
    final bottomRight = proj.project(
      const V3(PenaltyGame.goalHalfWidth, 0, 0),
    )!;

    // Darvoza ekran ichida.
    expect(topLeft.dx, greaterThan(0));
    expect(bottomRight.dx, lessThan(landscape.width));
    expect(topLeft.dy, greaterThan(0));
    expect(bottomRight.dy, lessThan(landscape.height));

    // Darvoza yetarlicha katta ko'rinadi.
    expect((bottomRight.dx - topLeft.dx) / landscape.width, greaterThan(0.2));
    expect((bottomRight.dy - topLeft.dy) / landscape.height, greaterThan(0.15));

    // To'p ekranning pastki qismida ko'rinadi.
    final ball = proj.project(PenaltyGame.ballHome)!;
    expect(ball.dy, lessThan(landscape.height));
    expect(ball.dy, greaterThan(landscape.height * 0.6));
  });

  test('zarba uchadi va natija yoziladi', () {
    final game = PenaltyGame();
    game.tapShoot(const Offset(358, 150), landscape);
    expect(game.shotsTaken, 1);
    expect(game.phase, ShotPhase.flying);

    var guard = 0;
    while (game.phase == ShotPhase.flying && guard++ < 400) {
      game.tick(1 / 60);
    }
    expect(game.phase, ShotPhase.result);
    expect(game.history.length, 1);
  });

  test('10 zarbadan keyin o\'yin tugaydi', () {
    final game = PenaltyGame();
    for (var i = 0; i < PenaltyGame.totalShots; i++) {
      expect(game.phase, ShotPhase.ready);
      game.tapShoot(const Offset(358, 150), landscape);
      var guard = 0;
      while (game.phase != ShotPhase.ready &&
          game.phase != ShotPhase.over &&
          guard++ < 900) {
        game.tick(1 / 60);
      }
    }
    expect(game.phase, ShotPhase.over);
    expect(game.shotsTaken, PenaltyGame.totalShots);
    expect(game.history.length, PenaltyGame.totalShots);
  });

  test('nishon olish nishonni darvoza tekisligiga o\'giradi', () {
    final game = PenaltyGame();
    game.beginAim(const Offset(358, 120), landscape);
    expect(game.phase, ShotPhase.aiming);
    expect(game.aim.y, greaterThan(1.4));
    game.updateAim(const Offset(470, 120), landscape);
    expect(game.aim.x, greaterThan(0.5));
    game.releaseShot();
    expect(game.phase, ShotPhase.flying);
  });

  for (final size in const [
    Size(716, 320),
    Size(800, 360),
    Size(640, 360),
    Size(915, 412),
  ]) {
    testWidgets(
      'O\'yin ekrani ${size.width.toInt()}x${size.height.toInt()} da xatosiz chiziladi',
      (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(const FodballApp());
        await tester.pump(const Duration(milliseconds: 16));
        await tester.pump(const Duration(milliseconds: 16));

        expect(find.text('FODBALL'), findsOneWidget);
        expect(find.text('GOALS'), findsOneWidget);
        expect(find.text('SHOT'), findsOneWidget);
        expect(tester.takeException(), isNull);

        // Nishonga olish va zarba.
        await tester.dragFrom(
          Offset(size.width / 2, size.height * 0.55),
          Offset(size.width * 0.1, -20),
        );
        await tester.pump(const Duration(milliseconds: 16));
        expect(tester.takeException(), isNull);

        for (var i = 0; i < 40; i++) {
          await tester.pump(const Duration(milliseconds: 16));
        }
        expect(tester.takeException(), isNull);
      },
    );
  }
}
