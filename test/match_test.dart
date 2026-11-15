import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/game3d/match_game.dart';
import 'package:fodball/game3d/vec3.dart';
import 'package:fodball/state/game_state.dart';

List<({String name, int number, int pace, int shooting, int passing})>
    _roster(String prefix) => [
          for (var i = 0; i < 11; i++)
            (
              name: '$prefix$i',
              number: i + 1,
              pace: 80,
              shooting: 80,
              passing: 80,
            ),
        ];

MatchGame _game() => MatchGame(
      homeNames: _roster('H'),
      awayNames: _roster('A'),
      matchLength: 60,
      enableHaptics: false,
      rng: Random(42),
    );

/// Raqibni maydondan uzoqlashtiradi — gol testlari uchun.
void _clearAway(MatchGame g) {
  for (final p in g.players) {
    if (p.team == 1) p.pos = V3(-40, 0, 0);
  }
}

void main() {
  test('22 o\'yinchi maydonda, kickoffdan keyin o\'yin boshlanadi', () {
    final g = _game();
    expect(g.players.length, 22);
    expect(g.phase, MatchPhase.kickoff);

    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    expect(g.phase, MatchPhase.playing);
    expect(g.ownerTeam >= 0, isTrue);
  });

  test('to\'p darvozadan o\'tsa gol hisobga olinadi', () {
    final g = _game();
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    // To'pni darvoza oldidan uchiramiz.
    _clearAway(g);
    g.ownerTeam = -1;
    g.ownerIndex = -1;
    g.ball = V3(MatchGame.pitchL - 0.5, MatchGame.ballR, 0);
    g.ballVel = const V3(25, 0.5, 0);

    var guard = 0;
    while (g.phase != MatchPhase.goal && guard++ < 120) {
      g.tick(1 / 60);
    }
    expect(g.phase, MatchPhase.goal);
    expect(g.scoreHome, 1);
  });

  test('golga keyin kickoff bilan o\'yin davom etadi', () {
    final g = _game();
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    _clearAway(g);
    g.ownerTeam = -1;
    g.ownerIndex = -1;
    g.ball = V3(MatchGame.pitchL - 0.5, MatchGame.ballR, 0);
    g.ballVel = const V3(25, 0.5, 0);
    var guard = 0;
    while (g.phase != MatchPhase.goal && guard++ < 120) {
      g.tick(1 / 60);
    }
    expect(g.phase, MatchPhase.goal);
    guard = 0;
    while (g.phase == MatchPhase.goal && guard++ < 600) {
      g.tick(1 / 60);
    }
    expect(g.phase, isNot(MatchPhase.goal));
    expect(g.scoreHome, 1);
  });

  test('vaqt tugagach FULL TIME', () {
    final g = _game();
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    g.elapsed = g.matchLength;
    g.tick(1 / 60);
    expect(g.isFullTime, isTrue);
  });

  test('o\'yin soati 90 daqiqagacha boradi', () {
    final g = _game();
    g.elapsed = 30;
    expect(g.clockMinute, inInclusiveRange(44, 45));
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    g.elapsed = g.matchLength;
    g.tick(1 / 60);
    expect(g.clockMinute, 90);
  });

  test('joystick boshqarilayotgan o\'yinchini harakatlantiradi', () {
    final g = _game();
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    g.setJoystick(1, 0);
    final me = g.players.firstWhere(
      (p) => p.team == 0 && p.index == g.controlled,
    );
    final startX = me.pos.x;
    for (var i = 0; i < 60; i++) {
      g.tick(1 / 60);
    }
    expect(me.pos.x, greaterThan(startX));
  });

  test('pass to\'pni jamoaga o\'tkazadi', () {
    final g = _game();
    for (var i = 0; i < 120; i++) {
      g.tick(1 / 60);
    }
    if (g.ownerTeam == 0) {
      g.pass();
      expect(g.ownerTeam, -1); // to'p uchda
      expect(g.wantReceiver >= 0, isTrue);
    }
  });

  group('GameState', () {
    test('g\'alaba jadval, karyera va valyutani yangilaydi', () {
      final s = GameState(rng: Random(1));
      final before = s.coins;
      final userRow = s.table.firstWhere((x) => x.isUser);
      final played = userRow.played;

      final reward = s.recordMatchResult(
        won: true,
        draw: false,
        goalsFor: 3,
        goalsAgainst: 1,
      );

      expect(reward.coins, 150000);
      expect(s.coins, before + 150000);
      expect(s.careerMatches, 129);
      expect(s.careerGoals, 89);
      expect(
        s.table.firstWhere((x) => x.isUser).played,
        played + 1,
      );
      // Jadval yutuqlarga qarab tartiblangan.
      for (var i = 0; i + 1 < s.table.length; i++) {
        expect(s.table[i].points >= s.table[i + 1].points, isTrue);
      }
    });

    test('yutuq sovg\'asi faqat bitta marta olinadi', () {
      final s = GameState(rng: Random(1));
      expect(s.claimAchievement('striker'), isFalse); // progress 7/10
      expect(s.claimAchievement('first_win'), isTrue);
      expect(s.claimAchievement('first_win'), isFalse);
    });

    test('transfer sotib olish coin talab qiladi', () {
      final s = GameState(rng: Random(1));
      s.coins = 200000000;
      final target = s.market.first;
      expect(s.buyPlayer(target), isTrue);
      expect(s.market.contains(target), isFalse);
      expect(s.reserves.contains(target.player), isTrue);

      final expensive = s.market.reduce(
        (a, b) => a.price > b.price ? a : b,
      );
      s.coins = 100;
      expect(s.buyPlayer(expensive), isFalse);
    });

    test('UCL final g\'alabasi chempionlikni ochadi', () {
      final s = GameState(rng: Random(1));
      expect(s.uclChampion, isFalse);
      s.recordMatchResult(
        won: true,
        draw: false,
        goalsFor: 2,
        goalsAgainst: 0,
        isFinal: true,
      );
      expect(s.uclChampion, isTrue);
      expect(s.achievements.firstWhere((a) => a.id == 'champion').isComplete,
          isTrue);
    });
  });
}
