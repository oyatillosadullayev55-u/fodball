import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'vec3.dart';

enum ShotPhase { ready, aiming, flying, result, over }

/// 3D konfetti bo'lakchasi.
class Confetti {
  Confetti({
    required this.pos,
    required this.vel,
    required this.color,
    required this.size,
    required this.spin,
  });

  V3 pos;
  V3 vel;
  final Color color;
  final double size;
  double spin;
  double life = 1;
}

/// Penalti o'yini: fizika, darvozabon sun'iy intellekti, hisob.
class PenaltyGame extends ChangeNotifier {
  PenaltyGame() {
    _resetShot();
  }

  // ---- Maydon o'lchamlari (metr) ----
  static const double goalHalfWidth = 3.66;
  static const double goalHeight = 2.44;
  static const double ballRadius = 0.11;
  static const double gravity = -9.8;
  static const int totalShots = 10;

  static const V3 ballHome = V3(0, ballRadius, -6.0);

  /// Kamera joylashuvi — barcha proyeksiya shu yerdan hisoblanadi.
  static const double camHeight = 1.75;
  static const double camZ = -9.6;

  ShotPhase phase = ShotPhase.ready;

  double time = 0;
  int shotsTaken = 0;
  int goals = 0;
  int streak = 0;
  int bestStreak = 0;

  String? lastResult;
  double resultTimer = 0;

  V3 ball = ballHome;
  V3 velocity = V3.zero;
  double curve = 0;
  double ballSpin = 0;
  bool resolved = false;
  double netRipple = 0;
  double shake = 0;
  double _ballAge = 0;

  final List<V3> trail = [];

  // ---- Nishon olish ----
  bool aiming = false;
  V3 aim = const V3(0, 1.15, 0);
  double power = 0.78;
  Offset _aimStart = Offset.zero;

  // ---- Darvozabon ----
  double keeperX = 0;
  double keeperTargetX = 0;
  double keeperDive = 0;
  int keeperDir = 1;
  bool keeperHigh = false;
  double keeperDelay = 0;
  bool keeperStarted = false;
  double keeperCoverX = 0;
  double keeperCoverY = 0.9;

  final List<Confetti> confetti = [];
  final List<String> history = [];
  final math.Random rng = math.Random();

  bool get isOver => phase == ShotPhase.over;
  int get shotsLeft => totalShots - shotsTaken;

  /// Joriy kadr uchun kamera (silkinish effekti bilan).
  Camera3D camera() {
    final s = shake > 0 ? math.sin(time * 70) * shake * 0.05 : 0.0;
    return Camera3D(
      eye: V3(s, camHeight, camZ),
      target: V3(s * 0.6, 1.15, 0),
      fovY: 0.92,
    );
  }

  Projector projectorFor(Size size) => Projector(camera(), size);

  // ---------------------------------------------------------------------------
  // Boshqaruv
  // ---------------------------------------------------------------------------

  void beginAim(Offset local, Size size) {
    if (phase != ShotPhase.ready) return;
    aiming = true;
    phase = ShotPhase.aiming;
    _aimStart = local;
    power = 0.7;
    _setAimFromScreen(local, size);
    notifyListeners();
  }

  void updateAim(Offset local, Size size) {
    if (!aiming) return;
    _setAimFromScreen(local, size);
    final drag = (local - _aimStart).distance;
    power = (0.6 + drag / (size.height * 1.1)).clamp(0.6, 1.0);
    notifyListeners();
  }

  void releaseShot() {
    if (phase != ShotPhase.aiming) return;
    aiming = false;
    _shoot(aim, power);
  }

  void tapShoot(Offset local, Size size) {
    if (phase != ShotPhase.ready) return;
    _setAimFromScreen(local, size);
    _shoot(aim, 0.82);
  }

  void _setAimFromScreen(Offset local, Size size) {
    final p = projectorFor(size).unproject(local, 0);
    aim = V3(p.x.clamp(-5.2, 5.2), p.y.clamp(0.05, 3.3), 0);
  }

  void _shoot(V3 target, double p) {
    shotsTaken++;
    resolved = false;
    _ballAge = 0;
    ball = ballHome;
    trail.clear();
    confetti.clear();
    netRipple = 0;

    final speed = 19.0 + 15.0 * p.clamp(0.0, 1.0);
    const dist = 6.0;
    final t = dist / speed;

    // Banan effekti: yon tezlanish, lekin nishonga baribir tegadi.
    curve = -target.x * 0.7;
    final ax = curve;
    final vx = (target.x - ballHome.x - 0.5 * ax * t * t) / t;
    final vy = (target.y - ballHome.y + 0.5 * -gravity * t * t) / t;
    final vz = dist / t;

    velocity = V3(vx, vy, vz);
    ballSpin = target.x * 3.0;
    phase = ShotPhase.flying;
    _planKeeper(target);
    HapticFeedback.selectionClick();
    notifyListeners();
  }

  void restart() {
    shotsTaken = 0;
    goals = 0;
    streak = 0;
    bestStreak = 0;
    confetti.clear();
    history.clear();
    _resetShot();
    notifyListeners();
  }

  void _resetShot() {
    phase = ShotPhase.ready;
    ball = ballHome;
    velocity = V3.zero;
    trail.clear();
    resolved = false;
    resultTimer = 0;
    lastResult = null;
    _ballAge = 0;
    keeperX = 0;
    keeperTargetX = 0;
    keeperDive = 0;
    keeperDir = 1;
    keeperHigh = false;
    keeperStarted = false;
    keeperDelay = 0;
    keeperCoverX = 0;
    keeperCoverY = 0.9;
    aim = const V3(0, 1.15, 0);
    power = 0.78;
  }

  // ---------------------------------------------------------------------------
  // Fizika
  // ---------------------------------------------------------------------------

  void tick(double dt) {
    dt = dt.clamp(0.0, 0.05);
    if (dt <= 0) return;
    time += dt;

    netRipple = math.max(0, netRipple - dt * 1.8);
    shake = math.max(0, shake - dt * 2.4);
    _updateConfetti(dt);

    if (phase == ShotPhase.flying || phase == ShotPhase.result) {
      _stepBall(dt);
    }

    if (phase == ShotPhase.flying && keeperStarted) {
      _stepKeeper(dt);
    }

    if (phase == ShotPhase.ready) {
      // Darvozabon tayyor holatda sal tebranadi.
      keeperX = math.sin(time * 1.3) * 0.18;
      keeperCoverX = keeperX;
      keeperCoverY = 0.9;
    }

    if (phase == ShotPhase.result) {
      resultTimer -= dt;
      if (resultTimer <= 0) {
        if (shotsTaken >= totalShots) {
          phase = ShotPhase.over;
        } else {
          _resetShot();
        }
      }
    }

    notifyListeners();
  }

  void _stepBall(double dt) {
    _ballAge += dt;
    const maxStep = 1 / 240;
    var remaining = dt;
    while (remaining > 0.0001 && (phase == ShotPhase.flying || phase == ShotPhase.result)) {
      final h = math.min(maxStep, remaining);
      remaining -= h;
      _integrate(h);
    }
    if (_ballAge > 3.2) velocity = V3.zero;
  }

  void _integrate(double h) {
    final prev = ball;
    velocity = V3(
      velocity.x + curve * 2.0 * h,
      velocity.y + gravity * h,
      velocity.z,
    );
    ball = ball + velocity * h;

    if (ball.y < ballRadius && velocity.y < 0) {
      ball = V3(ball.x, ballRadius, ball.z);
      velocity = V3(velocity.x * 0.9, -velocity.y * 0.45, velocity.z * 0.96);
      if (velocity.y.abs() < 0.7) velocity = V3(velocity.x, 0, velocity.z);
    }

    if (!resolved && prev.z < 0 && ball.z >= 0) {
      final t = (0 - prev.z) / (ball.z - prev.z);
      _resolveShot(prev.lerp(ball, t));
    }

    if (resolved && ball.z > 2.0) {
      // To'r ichida to'xtaydi.
      velocity = V3(velocity.x * 0.2, velocity.y * 0.1, -velocity.z.abs() * 0.1);
      ball = V3(ball.x, ball.y, 2.0);
    }

    if (trail.isEmpty || (trail.last - ball).length > 0.14) {
      trail.add(ball);
      if (trail.length > 16) trail.removeAt(0);
    }
  }

  void _resolveShot(V3 cross) {
    resolved = true;
    final inX = cross.x.abs() < goalHalfWidth - ballRadius * 0.4;
    final inY = cross.y > 0 && cross.y < goalHeight - ballRadius * 0.4;
    final saved = _keeperSaves(cross);

    if (inX && inY && !saved) {
      goals++;
      streak++;
      if (streak > bestStreak) bestStreak = streak;
      lastResult = 'GOAL!';
      history.add('goal');
      netRipple = 1;
      shake = 1;
      _burst(cross);
      velocity = V3(velocity.x * 0.35, velocity.y * 0.25, velocity.z * 0.3);
      HapticFeedback.mediumImpact();
    } else if (saved) {
      streak = 0;
      lastResult = 'SAVED';
      history.add('save');
      velocity = V3(-velocity.x * 0.5, velocity.y.abs() * 0.5 + 1.5, -velocity.z * 0.45);
      HapticFeedback.heavyImpact();
    } else {
      streak = 0;
      lastResult = 'MISS';
      history.add('miss');
    }

    phase = ShotPhase.result;
    resultTimer = 1.6;
  }

  bool _keeperSaves(V3 cross) {
    final dx = (cross.x - keeperCoverX).abs();
    final dy = (cross.y - keeperCoverY).abs();
    return dx < 0.62 && dy < 0.58;
  }

  void _planKeeper(V3 target) {
    final skill = (0.42 + 0.045 * shotsTaken).clamp(0.0, 0.88);
    final reads = rng.nextDouble() < skill;
    double guess;
    if (reads) {
      guess = target.x * (0.62 + rng.nextDouble() * 0.5);
    } else {
      guess = (rng.nextDouble() * 2 - 1) * goalHalfWidth * 0.85;
    }
    keeperTargetX = guess.clamp(-goalHalfWidth + 0.35, goalHalfWidth - 0.35);
    keeperDir = keeperTargetX >= 0 ? 1 : -1;
    keeperHigh = target.y > 1.35
        ? rng.nextDouble() < 0.72
        : rng.nextDouble() < 0.22;
    keeperDelay = 0.06 + rng.nextDouble() * 0.09;
    keeperStarted = true;
    keeperDive = 0;
    keeperCoverX = 0;
    keeperCoverY = 0.9;
  }

  void _stepKeeper(double dt) {
    if (keeperDelay > 0) {
      keeperDelay -= dt;
      return;
    }
    final speed = keeperHigh ? 5.4 : 6.6;
    final delta = keeperTargetX - keeperX;
    final step = speed * dt;
    if (delta.abs() <= step) {
      keeperX = keeperTargetX;
    } else {
      keeperX += delta.sign * step;
    }
    keeperDive = math.min(1, keeperDive + dt * 4.2);
    keeperCoverX = keeperX + keeperDir * 0.52 * keeperDive;
    keeperCoverY = keeperHigh ? 1.55 : 0.55;
  }

  // ---------------------------------------------------------------------------
  // Konfetti
  // ---------------------------------------------------------------------------

  void _burst(V3 at) {
    for (var i = 0; i < 46; i++) {
      final a = rng.nextDouble() * math.pi * 2;
      final sp = 1.5 + rng.nextDouble() * 3.5;
      confetti.add(
        Confetti(
          pos: at,
          vel: V3(
            math.cos(a) * sp,
            1.5 + rng.nextDouble() * 4.0,
            0.4 + rng.nextDouble() * 1.2,
          ),
          color: [
            const Color(0xFFC8FF4D),
            const Color(0xFFFFC542),
            const Color(0xFF4D7CFF),
            const Color(0xFFFFFFFF),
          ][rng.nextInt(4)],
          size: 0.03 + rng.nextDouble() * 0.05,
          spin: rng.nextDouble() * 6,
        ),
      );
    }
  }

  void _updateConfetti(double dt) {
    for (final c in confetti) {
      c.vel = V3(c.vel.x * 0.985, c.vel.y - 7.5 * dt, c.vel.z * 0.985);
      c.pos = c.pos + c.vel * dt;
      c.spin += dt * 8;
      c.life -= dt * 0.55;
    }
    confetti.removeWhere((c) => c.life <= 0 || c.pos.y < -0.5);
  }
}
