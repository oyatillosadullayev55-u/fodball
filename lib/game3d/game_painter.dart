import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'penalty_game.dart';
import 'vec3.dart';

/// O'yin sahnasini 3D proyeksiya bilan chizuvchi painter.
class GamePainter extends CustomPainter {
  GamePainter(this.game) : super(repaint: game);

  final PenaltyGame game;

  static const _grassLight = Color(0xFF1A5B34);
  static const _grassDark = Color(0xFF144728);
  static const _line = Color(0x8CE8F4FF);
  static const _post = Color(0xFFF2F7FF);
  static const _lime = Color(0xFFC8FF4D);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final proj = game.projectorFor(size);

    _paintSky(canvas, size);
    _paintStands(canvas, size, proj);
    _paintPitch(canvas, size, proj);
    _paintMarkings(canvas, proj);

    final ballBehindNet = game.ball.z > 0.45;
    if (ballBehindNet) {
      _paintBall(canvas, proj);
      _paintGoal(canvas, proj);
      _paintKeeper(canvas, proj);
    } else {
      _paintGoal(canvas, proj);
      _paintKeeper(canvas, proj);
      _paintBall(canvas, proj);
    }

    _paintAim(canvas, proj);
    _paintConfetti(canvas, proj);
    _paintVignette(canvas, size);
  }

  // ---------------------------------------------------------------------------
  // Osmon va tribuna
  // ---------------------------------------------------------------------------

  void _paintSky(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF03060E), Color(0xFF071326), Color(0xFF0A1B33)],
          stops: [0.0, 0.55, 1.0],
        ).createShader(rect),
    );

    // Mayoq yorug'liklari.
    for (final c in const [
      Alignment(-0.92, -0.85),
      Alignment(0.92, -0.85),
      Alignment(-0.55, -1.0),
      Alignment(0.55, -1.0),
    ]) {
      final center = Offset(
        size.width / 2 + c.x * size.width / 2,
        size.height / 2 + c.y * size.height / 2,
      );
      canvas.drawCircle(
        center,
        size.height * 0.55,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFFBFE4FF).withValues(alpha: 0.20),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: center, radius: size.height * 0.55)),
      );
    }
  }

  static final List<({V3 pos, Color color})> _crowd = _buildCrowd();

  static List<({V3 pos, Color color})> _buildCrowd() {
    final rng = math.Random(21);
    final list = <({V3 pos, Color color})>[];
    const colors = [
      Color(0xFF7E8FB8),
      Color(0xFFB9C6E4),
      Color(0xFFC8FF4D),
      Color(0xFFFFC542),
      Color(0xFF4D7CFF),
      Color(0xFF2A3A5E),
      Color(0xFF9AA8C7),
    ];
    for (var i = 0; i < 260; i++) {
      final z = 5.4 + rng.nextDouble() * 11.5;
      final rise = (z - 5.4) / 11.5;
      final y = 1.1 + rise * 7.2 + (rng.nextDouble() - 0.5) * 0.5;
      final x = (rng.nextDouble() * 2 - 1) * 26;
      list.add((pos: V3(x, y, z), color: colors[rng.nextInt(colors.length)]));
    }
    return list;
  }

  void _paintStands(Canvas canvas, Size size, Projector proj) {
    final a = proj.project(const V3(-30, 1.1, 5.2));
    final b = proj.project(const V3(30, 1.1, 5.2));
    final c = proj.project(const V3(30, 9.0, 17.0));
    final d = proj.project(const V3(-30, 9.0, 17.0));
    if (a == null || b == null || c == null || d == null) return;

    final path = Path()
      ..moveTo(a.dx, a.dy)
      ..lineTo(b.dx, b.dy)
      ..lineTo(c.dx, c.dy)
      ..lineTo(d.dx, d.dy)
      ..close();

    final bounds = path.getBounds();
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF101B31), Color(0xFF060B17)],
        ).createShader(bounds),
    );

    // Tomoshabinlar.
    final dot = Paint();
    for (final person in _crowd) {
      final p = proj.project(person.pos);
      if (p == null) continue;
      if (p.dx < -20 || p.dx > size.width + 20) continue;
      final r = (0.09 * proj.scaleAt(person.pos)).clamp(0.7, 2.6);
      dot.color = person.color.withValues(alpha: 0.55);
      canvas.drawCircle(p, r, dot);
    }

    // Reklama taxtalari.
    final ba = proj.project(const V3(-14, 0, 4.6));
    final bb = proj.project(const V3(14, 0, 4.6));
    final bc = proj.project(const V3(14, 0.9, 4.6));
    final bd = proj.project(const V3(-14, 0.9, 4.6));
    if (ba != null && bb != null && bc != null && bd != null) {
      final board = Path()
        ..moveTo(ba.dx, ba.dy)
        ..lineTo(bb.dx, bb.dy)
        ..lineTo(bc.dx, bc.dy)
        ..lineTo(bd.dx, bd.dy)
        ..close();
      final r = board.getBounds();
      canvas.drawPath(
        board,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF16223C), Color(0xFF223357), Color(0xFF16223C)],
          ).createShader(r),
      );
      final glow = Paint()
        ..color = _lime.withValues(alpha: 0.18)
        ..strokeWidth = 1.5;
      canvas.drawLine(
        Offset(r.left, r.bottom - 1),
        Offset(r.right, r.bottom - 1),
        glow,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Maydon
  // ---------------------------------------------------------------------------

  void _paintPitch(Canvas canvas, Size size, Projector proj) {
    const nearZ = -8.7;
    const farZ = 4.8;
    const halfX = 20.0;
    const step = 0.85;
    final paint = Paint();
    var z = nearZ;
    var i = 0;
    while (z < farZ) {
      final z2 = math.min(z + step, farZ);
      final a = proj.project(V3(-halfX, 0, z));
      final b = proj.project(V3(halfX, 0, z));
      final c = proj.project(V3(halfX, 0, z2));
      final d = proj.project(V3(-halfX, 0, z2));
      if (a != null && b != null && c != null && d != null) {
        paint.color = i.isEven ? _grassLight : _grassDark;
        canvas.drawPath(
          Path()
            ..moveTo(a.dx, a.dy)
            ..lineTo(b.dx, b.dy)
            ..lineTo(c.dx, c.dy)
            ..lineTo(d.dx, d.dy)
            ..close(),
          paint,
        );
      }
      z = z2;
      i++;
    }

    // Yorug'lik dog'i maydon markazida.
    final center = proj.project(const V3(0, 0, -1.5));
    if (center != null) {
      canvas.drawCircle(
        center,
        size.height * 0.55,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.07),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.height * 0.55),
          ),
      );
    }
  }

  void _paintMarkings(Canvas canvas, Projector proj) {
    final p = Paint()
      ..color = _line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    void poly(List<V3> pts, {bool close = false}) {
      final path = Path();
      var started = false;
      for (final v in pts) {
        final s = proj.project(v);
        if (s == null) continue;
        if (!started) {
          path.moveTo(s.dx, s.dy);
          started = true;
        } else {
          path.lineTo(s.dx, s.dy);
        }
      }
      if (close) path.close();
      if (started) canvas.drawPath(path, p);
    }

    // Darvoza chizig'i.
    poly(const [V3(-16, 0, 0), V3(16, 0, 0)]);
    // Jarima maydoni.
    poly(const [
      V3(-8.0, 0, 0),
      V3(-8.0, 0, -4.6),
      V3(8.0, 0, -4.6),
      V3(8.0, 0, 0),
    ]);
    // Darvoza maydoni.
    poly(const [
      V3(-3.9, 0, 0),
      V3(-3.9, 0, -1.7),
      V3(3.9, 0, -1.7),
      V3(3.9, 0, 0),
    ]);
    // Jarima yoyi.
    final arc = <V3>[];
    for (var i = 0; i <= 18; i++) {
      final a = math.pi * 0.18 + (math.pi * 0.64) * i / 18;
      arc.add(V3(math.cos(a) * 2.6, 0, -6 + math.sin(a) * 2.6));
    }
    poly(arc);

    // Penalti nuqtasi.
    final spot = proj.project(const V3(0, 0, -6));
    if (spot != null) {
      canvas.drawCircle(spot, 2.2, Paint()..color = _line);
    }
  }

  // ---------------------------------------------------------------------------
  // Darvoza
  // ---------------------------------------------------------------------------

  void _paintGoal(Canvas canvas, Projector proj) {
    const hw = PenaltyGame.goalHalfWidth;
    const gh = PenaltyGame.goalHeight;
    const depth = 2.05;
    final ripple = game.netRipple;

    // To'r orqa fon.
    final bgA = proj.project(const V3(-hw, 0, depth));
    final bgB = proj.project(const V3(hw, 0, depth));
    final bgC = proj.project(const V3(hw, gh, depth));
    final bgD = proj.project(const V3(-hw, gh, depth));
    if (bgA != null && bgB != null && bgC != null && bgD != null) {
      canvas.drawPath(
        Path()
          ..moveTo(bgA.dx, bgA.dy)
          ..lineTo(bgB.dx, bgB.dy)
          ..lineTo(bgC.dx, bgC.dy)
          ..lineTo(bgD.dx, bgD.dy)
          ..close(),
        Paint()..color = const Color(0xFF050B16).withValues(alpha: 0.72),
      );
    }

    final net = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    void line(V3 a, V3 b) {
      final pa = proj.project(a);
      final pb = proj.project(b);
      if (pa == null || pb == null) return;
      canvas.drawLine(pa, pb, net);
    }

    double wob(double x) =>
        ripple > 0 ? math.sin(game.time * 16 + x * 4) * 0.06 * ripple : 0;

    // Orqa to'r.
    for (var i = 0; i <= 18; i++) {
      final x = -hw + hw * 2 * i / 18;
      line(V3(x, 0, depth + wob(x)), V3(x, gh, depth + wob(x)));
    }
    for (var i = 0; i <= 8; i++) {
      final y = gh * i / 8;
      line(V3(-hw, y, depth + wob(-hw)), V3(hw, y, depth + wob(hw)));
    }

    // Yon to'rlar.
    for (var i = 0; i <= 7; i++) {
      final z = depth * i / 7;
      line(V3(-hw, 0, z), V3(-hw, gh, z));
      line(V3(hw, 0, z), V3(hw, gh, z));
    }
    for (var i = 0; i <= 8; i++) {
      final y = gh * i / 8;
      line(V3(-hw, y, 0), V3(-hw, y, depth));
      line(V3(hw, y, 0), V3(hw, y, depth));
    }

    // Ustki to'r.
    for (var i = 0; i <= 12; i++) {
      final x = -hw + hw * 2 * i / 12;
      line(V3(x, gh, 0), V3(x, gh, depth));
    }

    // Ustunlar.
    final scale = proj.scaleAt(const V3(0, 1.2, 0));
    final postW = math.max(3.0, 0.15 * scale);
    final glow = Paint()
      ..color = _post.withValues(alpha: 0.18)
      ..strokeWidth = postW * 2.2
      ..strokeCap = StrokeCap.round;
    final solid = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white,
          const Color(0xFFB9C8E4),
        ],
      ).createShader(const Rect.fromLTWH(0, 0, 40, 40))
      ..strokeWidth = postW
      ..strokeCap = StrokeCap.round;

    void bar(V3 a, V3 b) {
      final pa = proj.project(a);
      final pb = proj.project(b);
      if (pa == null || pb == null) return;
      canvas.drawLine(pa, pb, glow);
      canvas.drawLine(pa, pb, solid);
    }

    bar(const V3(-hw, 0, 0), const V3(-hw, gh, 0));
    bar(const V3(hw, 0, 0), const V3(hw, gh, 0));
    bar(const V3(-hw, gh, 0), const V3(hw, gh, 0));

    // To'rni ushlab turuvchi orqa ustunlar.
    final backPaint = Paint()
      ..color = _post.withValues(alpha: 0.45)
      ..strokeWidth = math.max(1.4, postW * 0.45)
      ..strokeCap = StrokeCap.round;
    for (final x in const [-hw, hw]) {
      final a = proj.project(V3(x, gh, 0));
      final b = proj.project(V3(x, gh, depth));
      if (a != null && b != null) canvas.drawLine(a, b, backPaint);
    }
  }

  // ---------------------------------------------------------------------------
  // Darvozabon
  // ---------------------------------------------------------------------------

  void _paintKeeper(Canvas canvas, Projector proj) {
    final dive = Curves.easeOutCubic.transform(game.keeperDive.clamp(0.0, 1.0));
    final dir = game.keeperDir.toDouble();
    final high = game.keeperHigh;
    final angle = -dir * 1.25 * dive;
    final hipX = game.keeperX + dir * 0.22 * dive;
    final hipY = 0.95 + (high ? 0.28 : -0.5) * dive;
    const z = 0.42;

    V3 local(double lx, double ly) {
      final c = math.cos(angle);
      final s = math.sin(angle);
      return V3(hipX + lx * c - ly * s, hipY + lx * s + ly * c, z);
    }

    final scale = proj.scaleAt(const V3(0, 1, 0));

    // Soya.
    final shadow = proj.project(V3(game.keeperX, 0.005, z));
    if (shadow != null) {
      canvas.drawOval(
        Rect.fromCenter(
          center: shadow,
          width: 1.5 * proj.scaleAt(V3(game.keeperX, 0, z)),
          height: 0.34 * proj.scaleAt(V3(game.keeperX, 0, z)),
        ),
        Paint()..color = Colors.black.withValues(alpha: 0.32),
      );
    }

    void limb(V3 a, V3 b, Color color, double meters, {StrokeCap cap = StrokeCap.round}) {
      final pa = proj.project(a);
      final pb = proj.project(b);
      if (pa == null || pb == null) return;
      canvas.drawLine(
        pa,
        pb,
        Paint()
          ..color = color
          ..strokeWidth = math.max(1.2, meters * scale)
          ..strokeCap = cap,
      );
    }

    final hip = local(0, 0);
    final shoulder = local(0, 0.5);
    final head = local(0, 0.73);
    final handL = local(-0.46, 0.4);
    final handR = local(0.46, 0.4);
    final kneeL = local(-0.17, -0.46);
    final kneeR = local(0.17, -0.46);
    final footL = local(-0.22, -0.92);
    final footR = local(0.22, -0.92);

    const shorts = Color(0xFF16233F);
    const jersey = Color(0xFFD8FF57);
    const skin = Color(0xFFE8B98F);

    // Oyoqlar.
    limb(hip, kneeL, shorts, 0.17);
    limb(kneeL, footL, shorts, 0.14);
    limb(hip, kneeR, shorts, 0.17);
    limb(kneeR, footR, shorts, 0.14);

    // Tana.
    limb(hip, shoulder, jersey, 0.42);

    // Qo'llar.
    limb(shoulder, handL, jersey, 0.11);
    limb(shoulder, handR, jersey, 0.11);

    // Qo'lqoplar.
    for (final hand in [handL, handR]) {
      final p = proj.project(hand);
      if (p == null) continue;
      canvas.drawCircle(
        p,
        math.max(1.4, 0.1 * proj.scaleAt(hand)),
        Paint()..color = const Color(0xFFF6FAFF),
      );
    }

    // Bosh.
    final hp = proj.project(head);
    if (hp != null) {
      final r = math.max(2.0, 0.135 * proj.scaleAt(head));
      canvas.drawCircle(hp, r, Paint()..color = skin);
      canvas.drawArc(
        Rect.fromCircle(center: hp, radius: r),
        math.pi * 1.05,
        math.pi * 0.9,
        true,
        Paint()..color = const Color(0xFF2B2118),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // To'p
  // ---------------------------------------------------------------------------

  void _paintBall(Canvas canvas, Projector proj) {
    final ball = game.ball;
    final center = proj.project(ball);
    if (center == null) return;
    final r = PenaltyGame.ballRadius * proj.scaleAt(ball);

    // Soya.
    final ground = proj.project(V3(ball.x, 0.004, ball.z));
    if (ground != null) {
      final h = ball.y.clamp(0.0, 4.0);
      final k = (1 - h / 5).clamp(0.25, 1.0);
      canvas.drawOval(
        Rect.fromCenter(
          center: ground,
          width: r * 2.6 * k,
          height: r * 0.95 * k,
        ),
        Paint()..color = Colors.black.withValues(alpha: 0.35 * k),
      );
    }

    // Iz (trail).
    for (var i = 0; i < game.trail.length; i++) {
      final t = i / game.trail.length;
      final p = proj.project(game.trail[i]);
      if (p == null) continue;
      final rr = PenaltyGame.ballRadius * proj.scaleAt(game.trail[i]) * (0.25 + t * 0.55);
      canvas.drawCircle(
        p,
        rr,
        Paint()..color = Colors.white.withValues(alpha: 0.05 + t * 0.13),
      );
    }

    if (r < 0.5) return;

    final rect = Rect.fromCircle(center: center, radius: r);
    canvas.drawCircle(
      center,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 0.95,
          colors: const [
            Color(0xFFFFFFFF),
            Color(0xFFF0F4FB),
            Color(0xFFB7C2D6),
            Color(0xFF5A6579),
          ],
          stops: const [0.0, 0.45, 0.8, 1.0],
        ).createShader(rect),
    );

    // To'p panellari.
    canvas.save();
    canvas.clipPath(Path()..addOval(rect));
    final patch = Paint()..color = const Color(0xFF1B2436);
    final spin = game.ballSpin + game.time * 0.4;
    canvas.drawPath(_pentagon(center, r * 0.30, spin * 0.2), patch);
    for (var i = 0; i < 5; i++) {
      final a = spin + i * math.pi * 2 / 5;
      final p = Offset(
        center.dx + math.cos(a) * r * 0.66,
        center.dy + math.sin(a) * r * 0.66,
      );
      canvas.drawPath(_pentagon(p, r * 0.24, a), patch);
    }
    canvas.restore();

    // Yorqin nuqta.
    canvas.drawCircle(
      Offset(center.dx - r * 0.32, center.dy - r * 0.38),
      r * 0.2,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
  }

  Path _pentagon(Offset c, double r, double rotation) {
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final a = rotation + i * math.pi * 2 / 5 - math.pi / 2;
      final p = Offset(c.dx + math.cos(a) * r, c.dy + math.sin(a) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    return path..close();
  }

  // ---------------------------------------------------------------------------
  // Nishon va traektoriya
  // ---------------------------------------------------------------------------

  void _paintAim(Canvas canvas, Projector proj) {
    if (game.phase != ShotPhase.aiming && game.phase != ShotPhase.ready) return;
    final aiming = game.phase == ShotPhase.aiming;
    final p = proj.project(game.aim);
    if (p == null) return;

    final pulse = 0.5 + 0.5 * math.sin(game.time * 6);
    final alpha = aiming ? 1.0 : 0.45;

    // Traektoriya.
    if (aiming) {
      final pts = _previewPath();
      final path = Path();
      var started = false;
      for (final v in pts) {
        final s = proj.project(v);
        if (s == null) continue;
        if (!started) {
          path.moveTo(s.dx, s.dy);
          started = true;
        } else {
          path.lineTo(s.dx, s.dy);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = _lime.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }

    final radius = 14.0 + pulse * 4;
    canvas.drawCircle(
      p,
      radius,
      Paint()
        ..color = _lime.withValues(alpha: 0.85 * alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      p,
      3.2,
      Paint()..color = _lime.withValues(alpha: alpha),
    );
    final cross = Paint()
      ..color = _lime.withValues(alpha: 0.5 * alpha)
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(p.dx - radius - 5, p.dy), Offset(p.dx - radius + 2, p.dy), cross);
    canvas.drawLine(Offset(p.dx + radius - 2, p.dy), Offset(p.dx + radius + 5, p.dy), cross);
    canvas.drawLine(Offset(p.dx, p.dy - radius - 5), Offset(p.dx, p.dy - radius + 2), cross);
    canvas.drawLine(Offset(p.dx, p.dy + radius - 2), Offset(p.dx, p.dy + radius + 5), cross);
  }

  List<V3> _previewPath() {
    const dist = 6.0;
    final speed = 19.0 + 15.0 * game.power;
    final t = dist / speed;
    final ax = -game.aim.x * 0.7;
    final vx = (game.aim.x - 0.5 * ax * t * t) / t;
    final vy = (game.aim.y - 0.11 + 0.5 * 9.8 * t * t) / t;
    final vz = dist / t;
    final pts = <V3>[];
    for (var i = 0; i <= 18; i++) {
      final tt = t * i / 18;
      pts.add(
        V3(
          vx * tt + 0.5 * ax * tt * tt,
          0.11 + vy * tt - 4.9 * tt * tt,
          -6 + vz * tt,
        ),
      );
    }
    return pts;
  }

  void _paintConfetti(Canvas canvas, Projector proj) {
    for (final c in game.confetti) {
      final p = proj.project(c.pos);
      if (p == null) continue;
      final s = (c.size * proj.scaleAt(c.pos)).clamp(1.0, 12.0);
      canvas.save();
      canvas.translate(p.dx, p.dy);
      canvas.rotate(c.spin);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: s, height: s * 0.55),
        Paint()..color = c.color.withValues(alpha: c.life.clamp(0.0, 1.0)),
      );
      canvas.restore();
    }
  }

  void _paintVignette(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          radius: 0.95,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.45),
          ],
          stops: const [0.55, 1.0],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant GamePainter oldDelegate) => true;
}
