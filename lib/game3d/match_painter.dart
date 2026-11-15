import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'match_game.dart';
import 'vec3.dart';

/// 3D o'yin sahnasi: stadion, maydon, o'yinchilar, to'p.
class MatchPainter extends CustomPainter {
  MatchPainter(this.game);

  final MatchGame game;

  static const _skinTones = [
    Color(0xFFE8B98E),
    Color(0xFFC98B5E),
    Color(0xFF9C6437),
    Color(0xFF74482A),
    Color(0xFFF2C9A4),
    Color(0xFFB5784C),
  ];

  static const _homeKit = _Kit(
    jersey: Color(0xFFFFFFFF),
    jerseyDark: Color(0xFFC9D4E6),
    shorts: Color(0xFF14213C),
    socks: Color(0xFFF4F7FF),
    trim: Color(0xFF16233F),
    number: Color(0xFF16233F),
  );
  static const _awayKit = _Kit(
    jersey: Color(0xFFE93B4F),
    jerseyDark: Color(0xFF8C1224),
    shorts: Color(0xFFF3F5FA),
    socks: Color(0xFFE93B4F),
    trim: Color(0xFFFFE4E8),
    number: Color(0xFFFFFFFF),
  );
  static const _homeGkKit = _Kit(
    jersey: Color(0xFF25D6A6),
    jerseyDark: Color(0xFF0E8F6E),
    shorts: Color(0xFF0B1426),
    socks: Color(0xFF25D6A6),
    trim: Color(0xFF04261C),
    number: Color(0xFF04261C),
  );
  static const _awayGkKit = _Kit(
    jersey: Color(0xFFFFC542),
    jerseyDark: Color(0xFFD99312),
    shorts: Color(0xFF1B1B22),
    socks: Color(0xFFFFC542),
    trim: Color(0xFF3A2A02),
    number: Color(0xFF3A2A02),
  );

  _Kit _kitFor(MatchPlayer p) {
    if (p.isGk) return p.team == 0 ? _homeGkKit : _awayGkKit;
    return p.team == 0 ? _homeKit : _awayKit;
  }

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
    _vignette(canvas, size);
  }

  void _vignette(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final radius = math.max(size.width, size.height) * 0.78;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, 0.1),
          radius: 0.9,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.38)],
          stops: const [0.55, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
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
            const Color(0xFF02040B),
            const Color(0xFF0A1830),
            const Color(0xFF102545),
          ],
        ).createShader(Offset.zero & size),
    );
    // Prozhektor halolari (gradient — blur'dan tezroq).
    for (final fx in [0.12, 0.5, 0.88]) {
      final center = Offset(size.width * fx, -size.height * 0.05);
      final radius = size.height * 0.55;
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.10),
              Colors.white.withValues(alpha: 0.02),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }
    // Yorug'lik ustunlari.
    final beam = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.09),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.8));
    for (final fx in [0.12, 0.5, 0.88]) {
      final x = size.width * fx;
      final path = Path()
        ..moveTo(x - 6, 0)
        ..lineTo(x + 6, 0)
        ..lineTo(x + size.width * 0.16, size.height * 0.8)
        ..lineTo(x - size.width * 0.16, size.height * 0.8)
        ..close();
      canvas.drawPath(path, beam);
    }
  }

  void _stands(Canvas canvas, Size size, Projector proj) {
    // Tashqi tribuna halqasi.
    final outer = _ringPath(proj, 20);
    if (outer == null) return;
    canvas.drawPath(
      outer,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF080D1A), Color(0xFF121A2E)],
        ).createShader(Offset.zero & size),
    );
    // Ichki (pastki) tribuna.
    final inner = _ringPath(proj, 7);
    if (inner == null) return;
    canvas.drawPath(inner, Paint()..color = const Color(0xFF1A2440));
    canvas.drawPath(
      inner,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Tomoshabinlar — ikki qator.
    final rand = math.Random(7);
    final crowd = Paint();
    for (var i = 0; i < 260; i++) {
      final x = (rand.nextDouble() * 2 - 1) * (MatchGame.pitchL + 16);
      final side = rand.nextBool() ? -1 : 1;
      final tier = rand.nextBool();
      final z = side *
          (MatchGame.pitchW + (tier ? 12 : 7) + rand.nextDouble() * 7);
      final p = V3(x, 0.4 + rand.nextDouble() * 2.4, z);
      final o = proj.project(p);
      if (o == null) continue;
      final s = proj.scaleAt(p);
      final tint = rand.nextDouble();
      crowd.color = (tint > 0.92
              ? const Color(0xFFFF4D5E)
              : tint > 0.84
                  ? const Color(0xFF4D7CFF)
                  : Color.lerp(
                      const Color(0xFF232E48),
                      const Color(0xFF56658C),
                      rand.nextDouble(),
                    )!)
          .withValues(alpha: 0.55);
      canvas.drawCircle(o, (0.16 * s).clamp(0.6, 3.2), crowd);
    }

    // Reklama to'sig'i.
    _lineOnGround(canvas, proj, [
      V3(-MatchGame.pitchL - 3, 0, -MatchGame.pitchW - 3),
      V3(MatchGame.pitchL + 3, 0, -MatchGame.pitchW - 3),
      V3(MatchGame.pitchL + 3, 0, MatchGame.pitchW + 3),
      V3(-MatchGame.pitchL - 3, 0, MatchGame.pitchW + 3),
    ], close: true);
  }

  Path? _ringPath(Projector proj, double grow) {
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
      // Stadion chiroqlari hovuzi.
      final c = proj.project(V3.zero);
      if (c != null) {
        final pool = Rect.fromCenter(
          center: c,
          width: MatchGame.pitchL * 1.9 * proj.scaleAt(V3.zero),
          height: MatchGame.pitchW * 1.4 * proj.scaleAt(V3.zero),
        );
        canvas.drawPath(
          outline,
          Paint()
            ..shader = RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.07),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 1.0],
            ).createShader(pool),
        );
      }
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

  Color _skinFor(MatchPlayer p) =>
      _skinTones[(p.index * 5 + p.team * 2) % _skinTones.length];

  Color _hairFor(MatchPlayer p) {
    const hair = [
      Color(0xFF17120D),
      Color(0xFF2B1B10),
      Color(0xFF101018),
      Color(0xFF4A2C15),
      Color(0xFF1A1A1A),
    ];
    return hair[(p.index * 3 + p.team) % hair.length];
  }

  void _player(Canvas canvas, Projector proj, MatchPlayer p) {
    final o = proj.project(p.pos);
    if (o == null) return;
    final s = proj.scaleAt(p.pos);
    if (s <= 0) return;

    final kit = _kitFor(p);
    final isUser = p.team == 0 && p.index == game.controlled;

    // Perspektiv masshtab, lekin o'yinchi juda kichrayib ketmasin.
    final h = math.max(1.85 * s, 15.5);
    final speed01 = (p.vel.length / 8.0).clamp(0.0, 1.0);
    final swing = math.sin(p.anim) * h * 0.085 * (0.3 + speed01);
    final bob = (1 - math.cos(p.anim * 2)) * h * 0.012 * speed01;
    final lean = math.sin(p.facing) * h * 0.04;

    final groundY = o.dy;
    final footY = groundY - bob;
    final cx = o.dx + lean;
    final headR = h * 0.105;
    final headCy = footY - h * 0.845;
    final shoulderY = footY - h * 0.70;
    final hipY = footY - h * 0.40;
    final torsoW = h * 0.235;
    final skin = _skinFor(p);

    // Soya.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(o.dx, groundY + 0.02 * s),
        width: h * 0.72,
        height: h * 0.24,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.34),
    );

    // Oyoqlar: paypoq + butsa.
    final legPaint = Paint()
      ..color = kit.socks
      ..strokeWidth = h * 0.072
      ..strokeCap = StrokeCap.round;
    final bootPaint = Paint()..color = const Color(0xFF0E121C);

    void leg(double side, double phase) {
      final x = cx + side * h * 0.052 + swing * phase;
      final hip = Offset(x - swing * phase * 0.4, hipY + h * 0.02);
      final ankle = Offset(x, footY - h * 0.045);
      canvas.drawLine(hip, ankle, legPaint);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(ankle.dx + side * h * 0.018, footY - h * 0.018),
          width: h * 0.105,
          height: h * 0.055,
        ),
        bootPaint,
      );
    }

    leg(-1, 1);
    leg(1, -1);

    // Qo'llar (tananing orqasida).
    final armPaint = Paint()
      ..color = kit.jersey
      ..strokeWidth = h * 0.052
      ..strokeCap = StrokeCap.round;

    void arm(double side, double phase) {
      final sx = cx + side * torsoW * 0.5;
      final ex = sx + side * h * 0.045 + swing * phase * 0.5;
      final ey = shoulderY + h * 0.235;
      canvas.drawLine(Offset(sx, shoulderY + h * 0.035), Offset(ex, ey), armPaint);
      canvas.drawCircle(
        Offset(ex, ey),
        h * 0.033,
        Paint()..color = skin,
      );
    }

    arm(-1, -1);
    arm(1, 1);

    // Shorts.
    final shortsRect = Rect.fromCenter(
      center: Offset(cx, hipY + h * 0.015),
      width: torsoW * 1.02,
      height: h * 0.155,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(shortsRect, Radius.circular(h * 0.035)),
      Paint()..color = kit.shorts,
    );

    // Tana (forma).
    final torso = Path()
      ..moveTo(cx - torsoW * 0.5, shoulderY + h * 0.015)
      ..quadraticBezierTo(
          cx - torsoW * 0.56, hipY, cx - torsoW * 0.5, hipY + h * 0.005)
      ..lineTo(cx + torsoW * 0.5, hipY + h * 0.005)
      ..quadraticBezierTo(
          cx + torsoW * 0.56, hipY, cx + torsoW * 0.5, shoulderY + h * 0.015)
      ..close();
    canvas.drawPath(
      torso,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kit.jersey, kit.jerseyDark],
        ).createShader(
          Rect.fromLTRB(
              cx - torsoW, shoulderY, cx + torsoW, hipY + h * 0.01),
        ),
    );
    // Kontur — maysa ustida aniq ko'rinish.
    canvas.drawPath(
      torso,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.38)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(0.8, h * 0.014),
    );
    // Forma detali (yoqa chizig'i).
    canvas.drawLine(
      Offset(cx - torsoW * 0.34, shoulderY + h * 0.075),
      Offset(cx + torsoW * 0.34, shoulderY + h * 0.075),
      Paint()
        ..color = kit.trim.withValues(alpha: 0.85)
        ..strokeWidth = math.max(0.7, h * 0.022),
    );

    // Raqam.
    if (h >= 19) {
      final tp = TextPainter(
        text: TextSpan(
          text: '${p.number}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: h * 0.115,
            height: 1,
            fontWeight: FontWeight.w900,
            color: kit.number.withValues(alpha: 0.9),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(cx - tp.width / 2, shoulderY + h * 0.135),
      );
    }

    // Bo'yin + bosh.
    canvas.drawLine(
      Offset(cx, shoulderY + h * 0.01),
      Offset(cx, headCy + headR * 0.7),
      Paint()
        ..color = skin
        ..strokeWidth = h * 0.05,
    );
    final headRect = Rect.fromCircle(center: Offset(cx, headCy), radius: headR);
    canvas.drawCircle(
      Offset(cx, headCy),
      headR,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.5),
          colors: [_lighten(skin, 0.12), skin, _darken(skin, 0.12)],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(headRect),
    );
    // Soch.
    canvas.drawArc(
      headRect.inflate(headR * 0.06),
      math.pi * 1.02,
      math.pi * 0.96,
      true,
      Paint()..color = _hairFor(p),
    );
    canvas.drawCircle(
      Offset(cx, headCy),
      headR,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(0.6, h * 0.008),
    );

    if (isUser) {
      // Boshqarilayotgan o'yinchi: yorug' halqa + strelka.
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(o.dx, groundY + 0.02 * s),
          width: h * 0.95,
          height: h * 0.34,
        ),
        Paint()
          ..color = AppColors.lime.withValues(alpha: 0.95)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.2, h * 0.022),
      );
      final tipY = headCy - headR * 2.6;
      final arrow = Path()
        ..moveTo(cx - h * 0.085, tipY - h * 0.09)
        ..lineTo(cx + h * 0.085, tipY - h * 0.09)
        ..lineTo(cx, tipY)
        ..close();
      canvas.drawPath(arrow, Paint()..color = AppColors.lime);

      // Ism yorlig'i.
      final label = TextPainter(
        text: TextSpan(
          text: p.name,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 9,
            height: 1.1,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: h * 3.4);
      final pill = Rect.fromCenter(
        center: Offset(o.dx, tipY - h * 0.22),
        width: label.width + 10,
        height: label.height + 4,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(pill, Radius.circular(pill.height / 2)),
        Paint()..color = Colors.black.withValues(alpha: 0.62),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(pill, Radius.circular(pill.height / 2)),
        Paint()
          ..color = AppColors.lime.withValues(alpha: 0.75)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      label.paint(canvas, Offset(pill.left + 5, pill.top + 2));
    }
  }

  Color _lighten(Color c, double t) => Color.lerp(c, Colors.white, t)!;
  Color _darken(Color c, double t) => Color.lerp(c, Colors.black, t)!;

  void _ball(Canvas canvas, Projector proj) {
    final ground = proj.project(V3(game.ball.x, 0, game.ball.z));
    final o = proj.project(game.ball);
    if (o == null || ground == null) return;
    final s = proj.scaleAt(game.ball);
    final r = math.max(2.8, MatchGame.ballR * s * 2.4);
    final hgt = game.ball.y;
    final shrink = 1 / (1 + hgt * 0.55);

    // Soya — balandlikka qarab kichrayadi.
    canvas.drawOval(
      Rect.fromCenter(
        center: ground,
        width: r * 2.3 * shrink,
        height: r * 0.9 * shrink,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.32),
    );

    // Yorug'lik hoshiyasi.
    final glow = Rect.fromCircle(center: o, radius: r * 1.6);
    canvas.drawCircle(
      o,
      r * 1.6,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.16),
            Colors.white.withValues(alpha: 0.0),
          ],
        ).createShader(glow),
    );

    // Asosiy shar.
    canvas.drawCircle(
      o,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.4),
          colors: const [
            Colors.white,
            Color(0xFFEDF1F9),
            Color(0xFFB9C4D6),
          ],
          stops: const [0.0, 0.65, 1.0],
        ).createShader(Rect.fromCircle(center: o, radius: r)),
    );

    // Qora panellar.
    final patch = Paint()..color = const Color(0xFF1B2334);
    _polygon(canvas, o, r * 0.40, -math.pi / 2, 5, patch);
    if (r > 3.5) {
      for (var i = 0; i < 3; i++) {
        final a = -math.pi / 2 + i * math.pi * 2 / 3 + 0.5;
        canvas.drawCircle(
          Offset(o.dx + math.cos(a) * r * 0.74, o.dy + math.sin(a) * r * 0.74),
          r * 0.16,
          patch,
        );
      }
    }

    canvas.drawCircle(
      o,
      r,
      Paint()
        ..color = const Color(0xFF2A3350).withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(0.8, r * 0.09),
    );
  }

  void _polygon(Canvas canvas, Offset c, double r, double rot, int sides,
      Paint paint) {
    final path = Path();
    for (var i = 0; i < sides; i++) {
      final a = rot + i * math.pi * 2 / sides;
      final pt = Offset(c.dx + math.cos(a) * r, c.dy + math.sin(a) * r);
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
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

/// Jamoa formasi ranglari.
class _Kit {
  const _Kit({
    required this.jersey,
    required this.jerseyDark,
    required this.shorts,
    required this.socks,
    required this.trim,
    required this.number,
  });

  final Color jersey;
  final Color jerseyDark;
  final Color shorts;
  final Color socks;
  final Color trim;
  final Color number;
}
