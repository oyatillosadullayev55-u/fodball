import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'vec3.dart';

enum MatchPhase { kickoff, playing, goal, fullTime }

/// 3D konfetti bo'lakchasi (penalti o'yini bilan bir xil g'oya).
class MatchConfetti {
  MatchConfetti({
    required this.pos,
    required this.vel,
    required this.color,
  });

  V3 pos;
  V3 vel;
  final Color color;
  double life = 1;
}

/// Maydondagi bitta o'yinchi.
class MatchPlayer {
  MatchPlayer({
    required this.team,
    required this.index,
    required this.name,
    required this.number,
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.home,
    this.isGk = false,
  });

  final int team;
  final int index;
  final String name;
  final int number;
  final int pace;
  final int shooting;
  final int passing;

  /// Tayanch (formation) nuqtasi.
  final V3 home;
  final bool isGk;

  V3 pos = V3.zero;
  V3 vel = V3.zero;
  double facing = 0;

  /// Yugurish sikli fazasi (radian).
  double anim = 0;

  double get speed => 5.9 + (pace - 60) / 40 * 2.6;
}

/// To'liq 11v11 3D o'yin: fizika, jamoa AI, hisob, taymer.
class MatchGame extends ChangeNotifier {
  MatchGame({
    required this.homeNames,
    required this.awayNames,
    this.matchLength = 150,
    this.enableHaptics = true,
    math.Random? rng,
  }) : _rng = rng ?? math.Random() {
    _spawnTeams();
    _kickoff(kickoffTeam: 0);
  }

  /// Jamoa a'zolari: (ism, raqam, tezlik, zarba, pas).
  final List<({String name, int number, int pace, int shooting, int passing})>
      homeNames;
  final List<({String name, int number, int pace, int shooting, int passing})>
      awayNames;

  /// O'yin davomiyligi (real soniya).
  final double matchLength;

  /// Haptik feedback (testlarda o'chiriladi).
  final bool enableHaptics;
  final math.Random _rng;

  // ---- Maydon (metr) ----
  static const double pitchL = 105 / 2; // x: -52.5..52.5
  static const double pitchW = 68 / 2; // z: -34..34
  static const double goalHW = 3.66;
  static const double goalH = 2.44;
  static const double ballR = 0.11;
  static const double gravity = -9.8;

  final List<MatchPlayer> players = [];

  MatchPhase phase = MatchPhase.kickoff;
  double time = 0;
  double elapsed = 0;
  double phaseTimer = 0;
  double kickoffTimer = 1.2;

  int scoreHome = 0;
  int scoreAway = 0;
  String lastScorer = '';
  int lastScorerTeam = -1;

  V3 ball = V3.zero;
  V3 ballVel = V3.zero;
  int ownerTeam = -1;
  int ownerIndex = -1;
  int controlled = 0;
  int kickoffTeam = 0;

  // Foydalanuvchi kiritmasi.
  double joyX = 0;
  double joyZ = 0;
  bool sprint = false;
  int wantReceiver = -1;

  double shake = 0;
  final List<MatchConfetti> confetti = [];

  bool get isFullTime => phase == MatchPhase.fullTime;
  bool get userHasBall => ownerTeam == 0;

  /// O'yin soati: 0..90 daqiqa.
  int get clockMinute => ((elapsed / matchLength) * 90).floor().clamp(0, 90);
  int get clockSecond =>
      (((elapsed / matchLength) * 90 * 60) % 60).floor().clamp(0, 59);

  void _buzz(Future<void> Function() f) {
    if (!enableHaptics) return;
    f();
  }

  // ---------------------------------------------------------------------------
  // Jamoa tuzilishi
  // ---------------------------------------------------------------------------

  void _spawnTeams() {
    for (var t = 0; t < 2; t++) {
      final names = t == 0 ? homeNames : awayNames;
      for (var i = 0; i < names.length; i++) {
        final n = names[i];
        final home = _spotFor(t, i, names.length);
        players.add(
          MatchPlayer(
            team: t,
            index: i,
            name: n.name,
            number: n.number,
            pace: n.pace,
            shooting: n.shooting,
            passing: n.passing,
            home: home,
            isGk: i == 0,
          ),
        );
      }
    }
  }

  /// 4-3-3 tayanch nuqtalari (x: o'yin yo'nalishi, z: eni).
  V3 _spotFor(int team, int i, int count) {
    final spots = <V3>[
      const V3(-48, 0, 0), // GK
      const V3(-38, 0, -26), // LB
      const V3(-40, 0, -9), // CB
      const V3(-40, 0, 9), // CB
      const V3(-38, 0, 26), // RB
      const V3(-14, 0, -20), // CM
      const V3(-20, 0, 0), // CM
      const V3(-14, 0, 20), // CM
      const V3(16, 0, -26), // LW
      const V3(24, 0, 0), // ST
      const V3(16, 0, 26), // RW
    ];
    final s = spots[i % spots.length];
    // Jamoa 1 oyni teskari o'ynaydi.
    return team == 0 ? s : V3(-s.x, 0, -s.z);
  }

  void _kickoff({required int kickoffTeam}) {
    this.kickoffTeam = kickoffTeam;
    for (final p in players) {
      p.pos = p.home;
      p.vel = V3.zero;
      p.facing = p.team == 0 ? 0 : math.pi;
    }
    ball = V3.zero.copyWith(y: ballR);
    ballVel = V3.zero;
    ownerTeam = -1;
    ownerIndex = -1;
    _selectNearestUser();
    phase = MatchPhase.kickoff;
    kickoffTimer = 1.2;
  }

  MatchPlayer? _owner() => ownerTeam < 0
      ? null
      : players.firstWhere((p) => p.team == ownerTeam && p.index == ownerIndex);

  // ---------------------------------------------------------------------------
  // Kiritma
  // ---------------------------------------------------------------------------

  void setJoystick(double x, double z) {
    joyX = x;
    joyZ = z;
  }

  void setSprint(bool v) => sprint = v;

  void pass() {
    if (phase != MatchPhase.playing || ownerTeam != 0) return;
    final me = _owner();
    if (me == null) return;
    final target = _bestPassTarget(me);
    if (target == null) return;
    _kickTo(target, power: 0.75);
    wantReceiver = target.index;
    _buzz(HapticFeedback.selectionClick);
    
  }

  void shoot() {
    if (phase != MatchPhase.playing || ownerTeam != 0) return;
    final me = _owner();
    if (me == null) return;
    final goalX = pitchL;
    final dist = (goalX - me.pos.x).abs();
    final corner = _rng.nextBool() ? 1.0 : -1.0;
    final targetZ = corner * (1.4 + _rng.nextDouble() * 1.8) + joyZ * 1.2;
    final lift = (dist > 24 ? 2.4 + _rng.nextDouble() : 0.8 + _rng.nextDouble() * 0.8)
        .clamp(0.6, goalH - 0.35);
    final power = (16 + me.shooting / 10 + (dist / 8)).clamp(17.0, 27.0);
    _kickAt(V3(goalX, lift, targetZ.clamp(-goalHW + 0.4, goalHW - 0.4)), power);
    wantReceiver = -1;
    _buzz(HapticFeedback.mediumImpact);
    
  }

  MatchPlayer? _bestPassTarget(MatchPlayer me) {
    MatchPlayer? best;
    var bestScore = -1e9;
    for (final p in players) {
      if (p.team != 0 || p == me || p.isGk) continue;
      final dx = p.pos.x - me.pos.x;
      final dz = p.pos.z - me.pos.z;
      final dist = math.sqrt(dx * dx + dz * dz);
      if (dist < 2) continue;
      final dot = dist > 0 ? (dx * joyX + dz * joyZ) / dist : 0;
      final forward = dx * 0.6; // oldinga pas yaxshiroq
      final open = _nearestOppDist(p) * 0.8;
      final score = dot * 14 + forward + open - dist * 0.4;
      if (score > bestScore) {
        bestScore = score;
        best = p;
      }
    }
    return best;
  }

  double _nearestOppDist(MatchPlayer p) {
    var d = 1e9;
    for (final q in players) {
      if (q.team == p.team) continue;
      final dd = (q.pos - p.pos).length;
      if (dd < d) d = dd;
    }
    return d;
  }

  void _kickTo(MatchPlayer target, {required double power}) {
    final me = _owner()!;
    final dist = (target.pos - me.pos).length;
    final lead = target.vel * (dist / (14 + 8 * power)) * 0.6;
    final aim = target.pos + lead;
    _kickAt(aim, 12 + 10 * power);
  }

  void _kickAt(V3 target, double speed) {
    final me = _owner()!;
    final dir = target - V3(me.pos.x, ballR, me.pos.z);
    final flat = math.sqrt(dir.x * dir.x + dir.z * dir.z);
    final t = (flat / speed).clamp(0.15, 3.0);
    final vel = V3(
      dir.x / t,
      (dir.y + 0.5 * -gravity * t * t) / t,
      dir.z / t,
    );
    ballVel = vel;
    ownerTeam = -1;
    ownerIndex = -1;
  }

  // ---------------------------------------------------------------------------
  // Asosiy sikl
  // ---------------------------------------------------------------------------

  void tick(double dt) {
    dt = dt.clamp(0.0, 0.05);
    if (dt <= 0) return;
    time += dt;
    shake = math.max(0, shake - dt * 2.2);
    _stepConfetti(dt);

    switch (phase) {
      case MatchPhase.kickoff:
        kickoffTimer -= dt;
        if (kickoffTimer <= 0) {
          phase = MatchPhase.playing;
          // Markazni o'rgan jamoa ST ga beramiz.
          final st = players.firstWhere(
            (p) => p.team == kickoffTeam && !p.isGk && p.index == 9,
          );
          ownerTeam = st.team;
          ownerIndex = st.index;
          if (st.team == 0) controlled = st.index;
        }
        notifyListeners();
        return;
      case MatchPhase.goal:
        phaseTimer -= dt;
        _stepBall(dt);
        if (phaseTimer <= 0) {
          _kickoff(kickoffTeam: lastScorerTeam == 0 ? 1 : 0);
        }
        notifyListeners();
        return;
      case MatchPhase.fullTime:
        notifyListeners();
        return;
      case MatchPhase.playing:
        elapsed += dt;
        if (elapsed >= matchLength) {
          phase = MatchPhase.fullTime;
          
          notifyListeners();
          return;
        }
    }

    _aiThink(dt);
    _stepPlayers(dt);
    _stepBall(dt);
    _possession(dt);
    _selectNearestUser();
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // AI
  // ---------------------------------------------------------------------------

  void _aiThink(double dt) {
    final carrier = _owner();

    for (final p in players) {
      if (p.team == 0 && p.index == controlled) continue;
      _steer(p, carrier);
    }
  }

  void _steer(MatchPlayer p, MatchPlayer? carrier) {
    V3 target;
    var speedMul = 1.0;

    if (p.isGk) {
      final goalX = p.team == 0 ? -pitchL : pitchL;
      target = V3(goalX + (p.team == 0 ? 1.6 : -1.6), 0, (ball.z * 0.35).clamp(-8.0, 8.0));
    } else if (carrier == p) {
      // To'p bizda: raqib darvozasiga yetaklaymiz.
      final attackX = p.team == 0 ? pitchL : -pitchL;
      final weave = math.sin(time * 1.7 + p.index) * 8;
      target = V3(attackX, 0, weave);
      speedMul = 0.92;
      _carrierDecide(p);
    } else if (carrier != null && carrier.team != p.team) {
      // Himoya: eng yaqin ikkitasi press qiladi.
      final rank = _pressRank(p);
      if (rank == 0) {
        target = carrier.pos;
        speedMul = 1.0;
      } else if (rank == 1) {
        target = carrier.pos + V3(0, 0, (p.pos.z > carrier.pos.z ? 6 : -6));
        speedMul = 0.85;
      } else {
        target = _shiftedHome(p);
      }
    } else if (carrier != null && carrier.team == p.team) {
      // Hujum: kenglikka yugurish.
      final attackX = p.team == 0 ? pitchL : -pitchL;
      final forward = (attackX - p.home.x).sign;
      target = p.home + V3(forward * 14, 0, 0) + V3(0, 0, (ball.z - p.pos.z) * 0.25);
    } else {
      // To'p erkin: eng yaqin o'yinchi qo'lga oladi.
      final nearestOwn = players
          .where((q) => q.team == p.team && !q.isGk)
          .reduce((a, b) => (a.pos - ball).length <= (b.pos - ball).length ? a : b);
      target = nearestOwn == p ? ball : _shiftedHome(p);
      speedMul = nearestOwn == p ? 1.0 : 0.8;
    }

    _moveToward(p, target, speedMul);
  }

  int _pressRank(MatchPlayer p) {
    final carrier = _owner();
    if (carrier == null) return 99;
    final mates = players
        .where((q) => q.team == p.team && !q.isGk)
        .toList()
      ..sort((a, b) =>
          (a.pos - carrier.pos).length.compareTo((b.pos - carrier.pos).length));
    return mates.indexOf(p);
  }

  V3 _shiftedHome(MatchPlayer p) {
    final shiftX = (ball.x * 0.3).clamp(-14.0, 14.0);
    final shiftZ = (ball.z * 0.35).clamp(-10.0, 10.0);
    return p.home + V3(shiftX, 0, shiftZ);
  }

  void _carrierDecide(MatchPlayer p) {
    final attackX = p.team == 0 ? pitchL : -pitchL;
    final dist = (attackX - p.pos.x).abs();
    if (dist < 24 && _rng.nextDouble() < 0.05) {
      // Zarba.
      final corner = _rng.nextBool() ? 1.0 : -1.0;
      _kickAt(
        V3(attackX, 0.7 + _rng.nextDouble() * 1.2, corner * (1.2 + _rng.nextDouble() * 1.6)),
        (17 + p.shooting / 10).clamp(17.0, 26.0),
      );
    } else if (_rng.nextDouble() < 0.012 && dist > 30) {
      // Pas.
      final mates = players.where((q) => q.team == p.team && q != p && !q.isGk).toList()
        ..sort((a, b) => (a.pos - p.pos).length.compareTo((b.pos - p.pos).length));
      if (mates.isNotEmpty) {
        final t = mates[_rng.nextInt(math.min(3, mates.length))];
        final keep = ownerTeam;
        final keepIdx = ownerIndex;
        ownerTeam = p.team;
        ownerIndex = p.index;
        _kickTo(t, power: 0.7);
        ownerTeam = keep;
        ownerIndex = keepIdx;
      }
    }
  }

  void _moveToward(MatchPlayer p, V3 target, double mul) {
    final d = target - p.pos;
    final flat = math.sqrt(d.x * d.x + d.z * d.z);
    if (flat < 0.4) {
      p.vel = V3.zero;
      return;
    }
    final speed = p.speed * mul * 0.86;
    final dir = V3(d.x / flat, 0, d.z / flat);
    // Tezlik o'zgarishini silliq qilish.
    final want = dir * speed;
    p.vel = p.vel + (want - p.vel) * 0.18;
    p.facing = math.atan2(dir.x, dir.z);
  }

  // ---------------------------------------------------------------------------
  // Foydalanuvchi boshqaruvi
  // ---------------------------------------------------------------------------

  void _stepPlayers(double dt) {
    for (final p in players) {
      if (p.team == 0 && p.index == controlled && phase == MatchPhase.playing) {
        // Joystick bilan boshqarish.
        final mag = math.sqrt(joyX * joyX + joyZ * joyZ);
        if (mag > 0.08) {
          final speed = p.speed * (sprint ? 1.42 : 1.0);
          final inv = mag > 1 ? 1 / mag : 1.0;
          p.vel = V3(joyX * inv * speed, 0, joyZ * inv * speed);
          p.facing = math.atan2(joyX, joyZ);
        } else {
          p.vel = V3.zero;
        }
      }
      p.pos = p.pos + p.vel * dt;
      p.anim += p.vel.length * dt * 2.4;
      p.pos = V3(
        p.pos.x.clamp(-pitchL - 2, pitchL + 2),
        0,
        p.pos.z.clamp(-pitchW - 2, pitchW + 2),
      );
    }
  }

  void _selectNearestUser() {
    if (ownerTeam == 0) {
      controlled = ownerIndex;
      wantReceiver = -1;
      return;
    }
    // Pasdan keyin qabul qiluvchiga o'tamiz.
    if (ownerTeam == -1 && wantReceiver >= 0) {
      controlled = wantReceiver;
      return;
    }
    // Erkin to'p raqibda — eng yaqin o'yinchi.
    var best = -1;
    var bd = 1e9;
    for (final p in players) {
      if (p.team != 0 || p.isGk) continue;
      final d = (p.pos - ball).length;
      if (d < bd) {
        bd = d;
        best = p.index;
      }
    }
    if (best >= 0 && (ownerTeam == -1 || bd < 14)) controlled = best;
  }

  // ---------------------------------------------------------------------------
  // To'p
  // ---------------------------------------------------------------------------

  void _possession(double dt) {
    if (ownerTeam >= 0) {
      final p = _owner()!;
      // Oldinda sirpanib yuradi.
      final ahead = V3(math.sin(p.facing), 0, math.cos(p.facing));
      ball = V3(p.pos.x + ahead.x * 0.55, ballR, p.pos.z + ahead.z * 0.55);
      ballVel = p.vel;
      // Raqib yondashib to'pni olishi mumkin (vaqtga bog'liq).
      for (final q in players) {
        if (q.team == p.team) continue;
        final d = (q.pos - ball).length;
        final stealRate = q.isGk ? 3.2 : 1.7;
        if (d < 0.62 && _rng.nextDouble() < stealRate * dt) {
          ownerTeam = q.team;
          ownerIndex = q.index;
          if (q.team == 0) controlled = q.index;

          return;
        }
      }
      return;
    }

    // Erkin to'pni olish.
    for (final p in players) {
      final reach = p.isGk && ball.y < 1.6 ? 1.1 : 0.66;
      if ((p.pos - ball).length < reach) {
        ownerTeam = p.team;
        ownerIndex = p.index;
        if (p.team == 0) controlled = p.index;
        return;
      }
    }
  }

  void _stepBall(double dt) {
    if (ownerTeam >= 0) return;
    ballVel = V3(ballVel.x, ballVel.y + gravity * dt, ballVel.z);
    ball = ball + ballVel * dt;

    // Maydon yuzasi.
    if (ball.y < ballR) {
      ball = V3(ball.x, ballR, ball.z);
      if (ballVel.y < 0) {
        ballVel = V3(ballVel.x * 0.88, -ballVel.y * 0.42, ballVel.z * 0.88);
        if (ballVel.y.abs() < 0.6) ballVel = V3(ballVel.x, 0, ballVel.z);
      }
    }
    // Yon chiziqlar — devor.
    if (ball.z.abs() > pitchW - ballR && ballVel.z.sign == (ball.z).sign) {
      ballVel = V3(ballVel.x * 0.72, ballVel.y, -ballVel.z * 0.6);
    }

    // Darvoza chiziqlari.
    final inGoalMouth = ball.z.abs() < goalHW && ball.y < goalH;
    if (ball.x > pitchL + 0.2) {
      if (inGoalMouth && ballVel.x > 0) {
        _goal(0);
      } else if (ball.x > pitchL + 1.2) {
        _resetToGk(defendingTeam: 1);
      }
    } else if (ball.x < -pitchL - 0.2) {
      if (inGoalMouth && ballVel.x < 0) {
        _goal(1);
      } else if (ball.x < -pitchL - 1.2) {
        _resetToGk(defendingTeam: 0);
      }
    }
  }

  void _goal(int team) {
    if (phase != MatchPhase.playing) return;
    if (team == 0) {
      scoreHome++;
    } else {
      scoreAway++;
    }
    lastScorerTeam = team;
    final scorer = _owner();
    lastScorer = scorer?.name ?? (team == 0 ? homeNames[9].name : awayNames[9].name);
    ownerTeam = -1;
    ownerIndex = -1;
    phase = MatchPhase.goal;
    phaseTimer = 2.6;
    shake = 1;
    _buzz(HapticFeedback.heavyImpact);
    _burst(ball);
    
  }

  void _resetToGk({required int defendingTeam}) {
    final gk = players.firstWhere((p) => p.team == defendingTeam && p.isGk);
    ball = gk.pos + V3(defendingTeam == 0 ? 2.2 : -2.2, ballR, 0);
    ballVel = V3.zero;
    ownerTeam = -1;
    ownerIndex = -1;
  }

  void _burst(V3 at) {
    const colors = [
      Color(0xFFC8FF4D),
      Color(0xFFFFC542),
      Color(0xFF4D7CFF),
      Color(0xFFFFFFFF),
    ];
    for (var i = 0; i < 60; i++) {
      final a = _rng.nextDouble() * math.pi * 2;
      final sp = 1.5 + _rng.nextDouble() * 4;
      confetti.add(
        MatchConfetti(
          pos: at,
          vel: V3(math.cos(a) * sp, 2 + _rng.nextDouble() * 5, math.sin(a) * sp),
          color: colors[_rng.nextInt(colors.length)],
        ),
      );
    }
  }

  void _stepConfetti(double dt) {
    for (final c in confetti) {
      c.vel = V3(c.vel.x * 0.985, c.vel.y - 7.5 * dt, c.vel.z * 0.985);
      c.pos = c.pos + c.vel * dt;
      c.life -= dt * 0.5;
    }
    confetti.removeWhere((c) => c.life <= 0 || c.pos.y < -0.5);
  }

  // ---------------------------------------------------------------------------
  // Kamera
  // ---------------------------------------------------------------------------

  Camera3D camera() {
    final s = shake > 0 ? math.sin(time * 60) * shake * 0.4 : 0.0;
    final cx = (ball.x * 0.45).clamp(-24.0, 24.0);
    // Kamera to'pni vertikal bo'yicha ham kuzatadi — o'yinchi ko'rinmay qolmaydi.
    final cz = (ball.z * 0.5).clamp(-17.0, 17.0);
    return Camera3D(
      eye: V3(cx + s, 28, cz - 42),
      target: V3(cx * 1.1, 0, cz + 5),
      fovY: 0.58,
    );
  }
}

extension on V3 {
  V3 copyWith({double? x, double? y, double? z}) =>
      V3(x ?? this.x, y ?? this.y, z ?? this.z);
}
