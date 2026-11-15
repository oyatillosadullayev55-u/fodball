import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'match_game.dart';
import 'vec3.dart';

/// 3D o'yin sahnasi: stadion, maydon, o'yinchilar, to'p.
class MatchPainter extends CustomPainter {
  MatchPainter(this.game)
      : homeColor = const Color(0xFFF5F5F5),
        awayColor = const Color(0xFF9C1F2E);

  final MatchGame game;
  final Color homeColor;
  final Color awayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final cam = game.camera();
    final proj = Projector(cam, size);

    _sky(canvas, size);
    _stands(canvas, size, proj);
    _pitch(canvas, proj);
    _goals(canvas, proj);

    // O'yinchilar: chuqurlik bo'yicha tartib.
    final ordered = [...game.players]
      ..sort((a, b) => proj.depthOf(b.pos).compareTo(proj.depthOf(a.pos)));
    for (final p in ordered) {
      _player(canvas, proj, p);
    }

    _ball(canvas, proj);
    _confetti(canvas, proj);
  }

  // ---------------------------------------------------------------------------

  void _sky(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF03060F),
            const Color(0xFF0A1830),
            const Color(0xFF0D1E3A),
          ],
        ).createShader(Offset.zero & size),
    );
    // Prozhektor yorug'liklari.
    for (final fx in [0.15, 0.5, 0.85]) {
      canvas.drawCircle(
        Offset(size.width * fx, -size.height * 0.15),
        size.height * 0.5,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.05)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60),
      );
    }
  }

  void _stands(Canvas canvas, Size size, Projector proj) {
    // Tribuna maydon atrofida: proyeksiya qilingan to'rtburchak zanjiri.
    final l = MatchGame.pitchL + 6;
    final w = MatchGame.pitchW + 6;
    final corners = [
      V3(-l, 0, -w),
      V3(l, 0, -w),
      V3(l, 0, w),
      V3(-l, 0, w),
    ].map(proj.project).toList();
    if (corners.any((c) => c == null)) return;
    final path = Path()
      ..moveTo(corners[0]!.dx, corners[0]!.dy)
      ..lineTo(corners[1]!.dx, corners[1]!.dy)
      ..lineTo(corners[2]!.dx, corners[2]!.dy)
      ..lineTo(corners[3]!.dx, corners[3]!.dy)
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = const Color(0xFF131A2C),
    );

    // Semsimon auditoriya nuqtalari.
    final crowd = Paint();
    final rand = math.Random(7);
    for (var i = 0; i < 130; i++) {
      final x = (rand.nextDouble() * 2 - 1) * (l + 4);
      final side = rand.nextBool() ? -1 : 1;
      final z = side * (w + rand.nextDouble() * 5);
      final o = proj.project(V3(x, 0.3 + rand.nextDouble() * 2.5, z));
      if (o == null) continue;
      final s = proj.scaleAt(V3(x, 0, z));
      crowd.color = Color.lerp(
        const Color(0xFF2A3550),
        const Color(0xFF4A5878),
        rand.nextDouble(),
      )!.withValues(alpha: 0.5);
      canvas.drawCircle(o, (0.18 * s).clamp(0.5, 3.5), crowd);
    }
  }

  Path? _pitchPath(Projector proj, double grow) {
    final l = MatchGame.pitchL + grow;
    final w = MatchGame.pitchW + grow;
    final pts = [
      V3(-l, 0, -w),
      V3(l, 0, -w),
      V3(l, 0, w),
      V3(-l, 0, w),
    ].map(proj.project).toList();
    if (pts.any((p) => p == null)) return null;
    return Path()
      ..moveTo(pts[0]!.dx, pts[0]!.dy)
      ..lineTo(pts[1]!.dx, pts[1]!.dy)
      ..lineTo(pts[2]!.dx, pts[2]!.dy)
      ..lineTo(pts[3]!.dx, pts[3]!.dy)
      ..close();
  }

  void _pitch(Canvas canvas, Projector proj) {
    // Maysazori: x bo'ylab chiziqli.
    const stripes = 12;
    for (var i = 0; i < stripes; i++) {
      final x0 = -MatchGame.pitchL + (105 / stripes) * i;
      final x1 = x0 + 105 / stripes;
      final path = _stripPath(proj, x0, x1);
      if (path == null) continue;
      canvas.drawPath(
        path,
        Paint()
          ..color = i.isEven
              ? const Color(0xFF14502F)
              : const Color(0xFF0F3B24),
      );
    }

    final outline = _pitchPath(proj, 0);
    if (outline != null) {
      canvas.drawPath(
        outline,
        Paint()
          ..color = const Color(0xFF0A2A18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }

    _pitchLines(canvas, proj);
  }

  Path? _stripPath(Projector proj, double x0, double x1) {
    final w = MatchGame.pitchW;
    final pts = [
      V3(x0, 0, -w),
      V3(x1, 0, -w),
      V3(x1, 0, w),
      V3(x0, 0, w),
    ].map(proj.project).toList();
    if (pts.any((p) => p == null)) return null;
    return Path()
      ..moveTo(pts[0]!.dx, pts[0]!.dy)
      ..lineTo(pts[1]!.dx, pts[1]!.dy)
      ..lineTo(pts[2]!.dx, pts[2]!.dy)
      ..lineTo(pts[3]!.dx, pts[3]!.dy)
      ..close();
  }

  void _lineOnGround(Canvas canvas, Projector proj, List<V3> pts,
      {required bool close}) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    var started = false;
    for (final p in pts) {
      final o = proj.project(p);
      if (o == null) continue;
      if (!started) {
        path.moveTo(o.dx, o.dy);
        started = true;
      } else {
        path.lineTo(o.dx, o.dy);
      }
    }
    if (close) path.close();
    canvas.drawPath(path, paint);
  }

  void _circleOnGround(Canvas canvas, Projector proj, V3 c, double r) {
    final pts = <V3>[
      for (var i = 0; i <= 28; i++)
        V3(c.x + math.cos(i / 28 * math.pi * 2) * r, 0,
            c.z + math.sin(i / 28 * math.pi * 2) * r),
    ];
    _lineOnGround(canvas, proj, pts, close: false);
  }

  void _pitchLines(Canvas canvas, Projector proj) {
    final l = MatchGame.pitchL;
    final w = MatchGame.pitchW;
    // Chegara.
    _lineOnGround(canvas, proj, [
      V3(-l, 0, -w),
      V3(l, 0, -w),
      V3(l, 0, w),
      V3(-l, 0, w),
    ], close: true);
    // O'rta.
    _lineOnGround(canvas, proj, [V3(0, 0, -w), V3(0, 0, w)], close: false);
    _circleOnGround(canvas, proj, V3.zero, 9.15);
    // Jarima maydonlari.
    for (final side in [-1.0, 1.0]) {
      final gx = side * l;
      _lineOnGround(canvas, proj, [
        V3(gx, 0, -20.16),
        V3(gx - side * 16.5, 0, -20.16),
        V3(gx - side * 16.5, 0, 20.16),
        V3(gx, 0, 20.16),
      ], close: false);
      _lineOnGround(canvas, proj, [
        V3(gx, 0, -9.16),
        V3(gx - side * 5.5, 0, -9.16),
        V3(gx - side * 5.5, 0, 9.16),
        V3(gx, 0, 9.16),
      ], close: false);
    }
  }

  void _goals(Canvas canvas, Projector proj) {
    final post = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    final net = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (final side in [-1.0, 1.0]) {
      final x = side * MatchGame.pitchL;
      final hw = MatchGame.goalHW;
      final backX = x + side * 1.6;
      final baseL = proj.project(V3(x, 0, -hw));
      final baseR = proj.project(V3(x, 0, hw));
      final topL = proj.project(V3(x, MatchGame.goalH, -hw));
      final topR = proj.project(V3(x, MatchGame.goalH, hw));
      if (baseL == null || baseR == null || topL == null || topR == null) continue;
      // Tiriklar.
      canvas.drawLine(baseL, topL, post);
      canvas.drawLine(baseR, topR, post);
      canvas.drawLine(topL, topR, post);
      // To'r skeleti.
      final backTL = proj.project(V3(backX, MatchGame.goalH, -hw * 0.8));
      final backTR = proj.project(V3(backX, MatchGame.goalH, hw * 0.8));
      if (backTL != null && backTR != null) {
        canvas.drawLine(topL, backTL, net);
        canvas.drawLine(topR, backTR, net);
        canvas.drawLine(backTL, backTR, net);
      }
      for (var i = 1; i < 4; i++) {
        final z = -hw + (i / 3) * 2 * hw;
        final front = proj.project(V3(x, 0, z));
        final back = proj.project(V3(backX, 0, z * 0.8));
        if (front != null && back != null) canvas.drawLine(front, back, net);
      }
    }
  }

  // ---------------------------------------------------------------------------

  void _player(Canvas canvas, Projector proj, MatchPlayer p) {
    final o = proj.project(p.pos);
    if (o == null) return;
    final s = proj.scaleAt(p.pos);
    final jersey = p.team == 0 ? homeColor : awayColor;
    final isUser = p.team == 0 && p.index == game.controlled;

    // Soyasi.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(o.dx, o.dy + 0.02 * s),
        width: 0.7 * s,
        height: 0.28 * s,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );

    final h = 1.8 * s; // bo'yi pikselda
    final wBody = 0.62 * s;

    // Oyoqlar.
    final legPaint = Paint()..color = const Color(0xFF1A2438);
    canvas.drawRect(
      Rect.fromLTWH(o.dx - wBody * 0.32, o.dy - h * 0.42, wBody * 0.24, h * 0.42),
      legPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(o.dx + wBody * 0.08, o.dy - h * 0.42, wBody * 0.24, h * 0.42),
      legPaint,
    );

    // Tana (forma).
    final bodyRect = Rect.fromLTWH(o.dx - wBody / 2, o.dy - h * 0.82, wBody, h * 0.44);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, Radius.circular(wBody * 0.28)),
      Paint()..color = jersey,
    );
    // Kollar.
    final armPaint = Paint()..color = jersey.withValues(alpha: 0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(o.dx - wBody * 0.72, o.dy - h * 0.8, wBody * 0.22, h * 0.34),
        Radius.circular(wBody * 0.1),
      ),
      armPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(o.dx + wBody * 0.5, o.dy - h * 0.8, wBody * 0.22, h * 0.34),
        Radius.circular(wBody * 0.1),
      ),
      armPaint,
    );

    // Bosh.
    final headR = 0.21 * s;
    canvas.drawCircle(
      Offset(o.dx, o.dy - h * 0.82 - headR),
      headR,
      Paint()..color = const Color(0xFFC8996C),
    );

    // Raqam (orqada).
    final numberStyle = TextStyle(
      fontSize: (0.26 * s).clamp(6, 14),
      fontWeight: FontWeight.w900,
      color: p.team == 0 ? const Color(0xFF232B3E) : Colors.white,
    );
    final tp = TextPainter(
      text: TextSpan(text: '${p.number}', style: numberStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(o.dx - tp.width / 2, o.dy - h * 0.68));

    if (isUser) {
      // Boshqarilayotgan o'yinchi halqasi.
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(o.dx, o.dy + 0.05 * s),
          width: 1.0 * s,
          height: 0.4 * s,
        ),
        Paint()
          ..color = AppColors.lime
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      // Ism yorlig'i.
      final label = TextPainter(
        text: TextSpan(
          text: p.name,
          style: TextStyle(
            fontSize: (0.24 * s).clamp(8, 13),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            shadows: const [Shadow(color: Colors.black87, blurRadius: 4)],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, Offset(o.dx - label.width / 2, o.dy - h - headR - label.height - 4));
    }
  }

  void _ball(Canvas canvas, Projector proj) {
    final ground = proj.project(V3(game.ball.x, 0, game.ball.z));
    final o = proj.project(game.ball);
    if (o == null || ground == null) return;
    final s = proj.scaleAt(game.ball);
    final r = math.max(2.0, MatchGame.ballR * s);

    // Soyasi — balandlikka qarab kichraydi.
    final hgt = game.ball.y;
    canvas.drawOval(
      Rect.fromCenter(
        center: ground,
        width: r * 2 * (1 / (1 + hgt * 0.6)),
        height: r * 0.8 * (1 / (1 + hgt * 0.6)),
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.3),
    );

    canvas.drawCircle(o, r, Paint()..color = Colors.white);
    canvas.drawCircle(
      o,
      r,
      Paint()
        ..color = const Color(0xFF2A3350)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    canvas.drawCircle(o - Offset(r * 0.3, r * 0.2), r * 0.35,
        Paint()..color = const Color(0xFF2A3350).withValues(alpha: 0.6));
  }

  void _confetti(Canvas canvas, Projector proj) {
    for (final c in game.confetti) {
      final o = proj.project(c.pos);
      if (o == null) continue;
      final s = proj.scaleAt(c.pos);
      canvas.drawRect(
        Rect.fromCenter(
          center: o,
          width: 0.16 * s,
          height: 0.1 * s,
        ),
        Paint()..color = c.color.withValues(alpha: c.life.clamp(0.0, 1.0)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant MatchPainter oldDelegate) => true;
}
