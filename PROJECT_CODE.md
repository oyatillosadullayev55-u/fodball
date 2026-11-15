# Fodball 3D — to‘liq kod

> Bu hujjat loyihaning barcha manba fayllarini bir joyda jamlaydi.

- Flutter 3.47 / Dart 3.13
- Tashqi 3D paketlar yo‘q — o‘zimizning proyeksiya dvigateli
- `flutter analyze`: 0 issue · `flutter test`: 33 test o‘tadi

---

## Mundarija

- `lib/data/mock_data.dart`
- `lib/game3d/game_painter.dart`
- `lib/game3d/match_game.dart`
- `lib/game3d/match_painter.dart`
- `lib/game3d/penalty_game.dart`
- `lib/game3d/vec3.dart`
- `lib/main.dart`
- `lib/models/models.dart`
- `lib/screens/achievements_screen.dart`
- `lib/screens/career_screen.dart`
- `lib/screens/champions_screen.dart`
- `lib/screens/game_screen.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/match_screen.dart`
- `lib/screens/settings_screen.dart`
- `lib/screens/store_screen.dart`
- `lib/screens/team_screen.dart`
- `lib/screens/tournaments_screen.dart`
- `lib/screens/training_screen.dart`
- `lib/screens/transfers_screen.dart`
- `lib/state/game_state.dart`
- `lib/theme/app_colors.dart`
- `lib/theme/app_theme.dart`
- `lib/widgets/ui.dart`
- `test/game_test.dart`
- `test/match_test.dart`
- `test/screenshot_test.dart`
- `test/widget_test.dart`
- `pubspec.yaml`

---

## `lib/data/mock_data.dart`

```dart
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';

abstract final class MockData {
  // ---- Profil ----
  static const userName = 'Oyatillo FC';
  static const userHandle = 'Oyatillo_4349';
  static const managerTitle = 'Manager';
  static const level = 12;
  static const xp = 2450;
  static const xpMax = 5000;
  static const coins = 3250000;
  static const gems = 8750;

  // ---- Klublar ----
  static const realMadrid = Club(
    name: 'Real Madrid',
    short: 'RMA',
    crestColors: [Color(0xFFFEE48B), Color(0xFF8A6D1D)],
  );
  static const barcelona = Club(
    name: 'Barcelona',
    short: 'BAR',
    crestColors: [Color(0xFF9C1F2E), Color(0xFF004D98)],
  );
  static const atletico = Club(
    name: 'Atlético Madrid',
    short: 'ATM',
    crestColors: [Color(0xFFCB3524), Color(0xFF26437A)],
  );
  static const villarreal = Club(
    name: 'Villarreal',
    short: 'VIL',
    crestColors: [Color(0xFFFFF36E), Color(0xFF235B4E)],
  );
  static const sevilla = Club(
    name: 'Sevilla',
    short: 'SEV',
    crestColors: [Color(0xFFFFFFFF), Color(0xFFC1272D)],
  );

  static const userClub = realMadrid;
  static const rivalClub = barcelona;

  // ---- Asosiy tarkib (4-3-3) ----
  static const squad = <Player>[
    Player(
      name: 'Alisson',
      position: 'GK',
      rating: 96,
      number: 1,
      alignment: Alignment(0, 0.94),
      color: Color(0xFFF5B301),
      flag: [Color(0xFF009C3B), Color(0xFFFFDF00)],
      pace: 55, shooting: 45, passing: 88, defending: 96,
    ),
    Player(
      name: 'Hernández',
      position: 'LB',
      rating: 93,
      number: 6,
      alignment: Alignment(-0.78, 0.6),
      color: Color(0xFFE23E57),
      flag: [Color(0xFF0055A4), Color(0xFFEF4135)],
      pace: 88, shooting: 70, passing: 84, defending: 92,
    ),
    Player(
      name: 'van Dijk',
      position: 'CB',
      rating: 94,
      number: 4,
      alignment: Alignment(-0.26, 0.68),
      color: Color(0xFFE23E57),
      flag: [Color(0xFFAE1C28), Color(0xFF21468B)],
      pace: 82, shooting: 68, passing: 86, defending: 95,
    ),
    Player(
      name: 'Rüdiger',
      position: 'CB',
      rating: 95,
      number: 2,
      alignment: Alignment(0.26, 0.68),
      color: Color(0xFFE23E57),
      flag: [Color(0xFF000000), Color(0xFFDD0000)],
      pace: 85, shooting: 62, passing: 82, defending: 94,
    ),
    Player(
      name: 'Hakimi',
      position: 'RB',
      rating: 93,
      number: 3,
      alignment: Alignment(0.78, 0.6),
      color: Color(0xFF2F6BFF),
      flag: [Color(0xFFC1272D), Color(0xFF006233)],
      pace: 94, shooting: 74, passing: 83, defending: 86,
    ),
    Player(
      name: 'Pedri',
      position: 'CM',
      rating: 95,
      number: 8,
      alignment: Alignment(-0.55, 0.16),
      color: Color(0xFF2F6BFF),
      flag: [Color(0xFFFFD800), Color(0xFFAA151B)],
      pace: 84, shooting: 82, passing: 95, defending: 80,
    ),
    Player(
      name: 'Bellingham',
      position: 'CM',
      rating: 96,
      number: 5,
      alignment: Alignment(0, 0.26),
      color: Color(0xFFE23E57),
      flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)],
      pace: 83, shooting: 90, passing: 92, defending: 84,
    ),
    Player(
      name: 'De Bruyne',
      position: 'CM',
      rating: 96,
      number: 17,
      alignment: Alignment(0.55, 0.16),
      color: Color(0xFF6CABDD),
      flag: [Color(0xFF000000), Color(0xFFFFD90C)],
      pace: 79, shooting: 91, passing: 97, defending: 72,
    ),
    Player(
      name: 'Vinicius Jr.',
      position: 'LW',
      rating: 97,
      number: 7,
      alignment: Alignment(-0.78, -0.62),
      color: Color(0xFFE23E57),
      flag: [Color(0xFF009C3B), Color(0xFFFFDF00)],
      pace: 96, shooting: 88, passing: 87, defending: 45,
    ),
    Player(
      name: 'Mbappé',
      position: 'ST',
      rating: 99,
      number: 9,
      alignment: Alignment(0, -0.8),
      color: Color(0xFFE23E57),
      flag: [Color(0xFF0055A4), Color(0xFFEF4135)],
      pace: 99, shooting: 97, passing: 86, defending: 42,
    ),
    Player(
      name: 'Salah',
      position: 'RW',
      rating: 98,
      number: 11,
      alignment: Alignment(0.78, -0.62),
      color: Color(0xFFC8102E),
      flag: [Color(0xFFCE1126), Color(0xFF000000)],
      pace: 95, shooting: 93, passing: 88, defending: 48,
    ),
  ];

  // ---- Zaxira ----
  static const reserves = <Player>[
    Player(
      name: 'Courtois',
      position: 'GK',
      rating: 94,
      number: 13,
      color: Color(0xFF6CABDD),
      flag: [Color(0xFF000000), Color(0xFFFFD90C)],
    ),
    Player(
      name: 'Camavinga',
      position: 'CM',
      rating: 90,
      number: 22,
      color: Color(0xFF2F6BFF),
      flag: [Color(0xFF0055A4), Color(0xFFEF4135)],
    ),
    Player(
      name: 'Valverde',
      position: 'CM',
      rating: 94,
      number: 15,
      color: Color(0xFF2F6BFF),
      flag: [Color(0xFF5CBFEB), Color(0xFFFFFFFF)],
    ),
    Player(
      name: 'Rodrygo',
      position: 'RW',
      rating: 93,
      number: 21,
      color: Color(0xFFE23E57),
      flag: [Color(0xFF009C3B), Color(0xFFFFDF00)],
    ),
    Player(
      name: 'Gakpo',
      position: 'LW',
      rating: 91,
      number: 19,
      color: Color(0xFF6CABDD),
      flag: [Color(0xFFAE1C28), Color(0xFF21468B)],
    ),
  ];

  // ---- Packdan tushishi mumkin bo'lgan o'yinchilar ----
  static const packPool = <Player>[
    Player(name: 'Haaland', position: 'ST', rating: 97, number: 9, color: Color(0xFF6CABDD), flag: [Color(0xFFBA0C2F), Color(0xFF00205B)], pace: 93, shooting: 96, passing: 78, defending: 45),
    Player(name: 'Kane', position: 'ST', rating: 95, number: 10, color: Color(0xFFFFFFFF), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)], pace: 74, shooting: 95, passing: 84, defending: 48),
    Player(name: 'Saka', position: 'RW', rating: 94, number: 7, color: Color(0xFFEDBB00), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)], pace: 90, shooting: 87, passing: 88, defending: 52),
    Player(name: 'Foden', position: 'CM', rating: 94, number: 47, color: Color(0xFF6CABDD), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)], pace: 87, shooting: 88, passing: 92, defending: 60),
    Player(name: 'Musiala', position: 'CM', rating: 93, number: 42, color: Color(0xFFDC052D), flag: [Color(0xFF000000), Color(0xFFDD0000)], pace: 89, shooting: 86, passing: 90, defending: 58),
    Player(name: 'Wirtz', position: 'CM', rating: 92, number: 10, color: Color(0xFFE32221), flag: [Color(0xFF000000), Color(0xFFDD0000)], pace: 85, shooting: 85, passing: 91, defending: 55),
    Player(name: 'Leão', position: 'LW', rating: 92, number: 10, color: Color(0xFFFB090B), flag: [Color(0xFF046A38), Color(0xFFDA291C)], pace: 94, shooting: 85, passing: 84, defending: 40),
    Player(name: 'Osimhen', position: 'ST', rating: 92, number: 9, color: Color(0xFF12A0D7), flag: [Color(0xFF008751), Color(0xFFFFFFFF)], pace: 91, shooting: 89, passing: 72, defending: 42),
    Player(name: 'Kvaratskhelia', position: 'LW', rating: 91, number: 77, color: Color(0xFF0064AA), flag: [Color(0xFFFFFFFF), Color(0xFFFF0000)], pace: 92, shooting: 84, passing: 86, defending: 38),
    Player(name: 'Barella', position: 'CM', rating: 91, number: 23, color: Color(0xFF0064AA), flag: [Color(0xFF0064AA), Color(0xFFFFFFFF)], pace: 84, shooting: 82, passing: 89, defending: 76),
    Player(name: 'TAA', position: 'RB', rating: 92, number: 66, color: Color(0xFFC8102E), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)], pace: 86, shooting: 85, passing: 93, defending: 80),
    Player(name: 'Koundé', position: 'RB', rating: 90, number: 23, color: Color(0xFF9C1F2E), flag: [Color(0xFF0055A4), Color(0xFFEF4135)], pace: 89, shooting: 70, passing: 84, defending: 89),
    Player(name: 'Saliba', position: 'CB', rating: 91, number: 2, color: Color(0xFFEF0107), flag: [Color(0xFF0055A4), Color(0xFFEF4135)], pace: 87, shooting: 62, passing: 82, defending: 91),
    Player(name: 'Gabriel', position: 'CB', rating: 90, number: 6, color: Color(0xFFEF0107), flag: [Color(0xFF009C3B), Color(0xFFFFDF00)], pace: 84, shooting: 65, passing: 80, defending: 90),
    Player(name: 'Ter Stegen', position: 'GK', rating: 92, number: 1, color: Color(0xFF9C1F2E), flag: [Color(0xFFFFD800), Color(0xFFAA151B)], pace: 52, shooting: 40, passing: 86, defending: 92),
    Player(name: 'Donnarumma', position: 'GK', rating: 93, number: 99, color: Color(0xFF004170), flag: [Color(0xFF0064AA), Color(0xFFFFFFFF)], pace: 50, shooting: 38, passing: 84, defending: 93),
  ];

  // ---- Transfer bozori ----
  static const transferMarket = <TransferTarget>[
    TransferTarget(player: Player(name: 'Haaland', position: 'ST', rating: 97, number: 9, color: Color(0xFF6CABDD), flag: [Color(0xFFBA0C2F), Color(0xFF00205B)]), price: 185000000, sellingClub: 'Man City'),
    TransferTarget(player: Player(name: 'Kane', position: 'ST', rating: 95, number: 10, color: Color(0xFFFFFFFF), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)]), price: 95000000, sellingClub: 'Bayern'),
    TransferTarget(player: Player(name: 'Foden', position: 'CM', rating: 94, number: 47, color: Color(0xFF6CABDD), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)]), price: 110000000, sellingClub: 'Man City'),
    TransferTarget(player: Player(name: 'Saka', position: 'RW', rating: 94, number: 7, color: Color(0xFFEDBB00), flag: [Color(0xFFFFFFFF), Color(0xFFCE1124)]), price: 120000000, sellingClub: 'Arsenal'),
    TransferTarget(player: Player(name: 'Musiala', position: 'CM', rating: 93, number: 42, color: Color(0xFFDC052D), flag: [Color(0xFF000000), Color(0xFFDD0000)]), price: 130000000, sellingClub: 'Bayern'),
    TransferTarget(player: Player(name: 'Saliba', position: 'CB', rating: 91, number: 2, color: Color(0xFFEF0107), flag: [Color(0xFF0055A4), Color(0xFFEF4135)]), price: 85000000, sellingClub: 'Arsenal'),
    TransferTarget(player: Player(name: 'Wirtz', position: 'CM', rating: 92, number: 10, color: Color(0xFFE32221), flag: [Color(0xFF000000), Color(0xFFDD0000)]), price: 140000000, sellingClub: 'Leverkusen'),
    TransferTarget(player: Player(name: 'Donnarumma', position: 'GK', rating: 93, number: 99, color: Color(0xFF004170), flag: [Color(0xFF0064AA), Color(0xFFFFFFFF)]), price: 75000000, sellingClub: 'PSG'),
  ];

  // ---- Jadval (LaLiga) ----
  static const standings = <Standing>[
    Standing(club: realMadrid, played: 12, won: 11, drawn: 1, lost: 0, goalsFor: 34, goalsAgainst: 9, isUser: true),
    Standing(club: barcelona, played: 12, won: 10, drawn: 1, lost: 1, goalsFor: 37, goalsAgainst: 12),
    Standing(club: atletico, played: 12, won: 9, drawn: 1, lost: 2, goalsFor: 26, goalsAgainst: 11),
    Standing(club: villarreal, played: 12, won: 8, drawn: 2, lost: 2, goalsFor: 24, goalsAgainst: 14),
    Standing(club: sevilla, played: 12, won: 7, drawn: 3, lost: 2, goalsFor: 19, goalsAgainst: 13),
  ];

  // ---- Keyingi o'yin ----
  static const nextMatch = MatchInfo(
    competition: 'CHAMPIONS LEAGUE',
    home: realMadrid,
    away: barcelona,
    dateLabel: 'Sat, Nov 15, 2026',
    timeLabel: '21:00',
    isFinal: true,
  );

  // ---- Do'kon ----
  static const packs = <Pack>[
    Pack(
      name: 'Standard Pack',
      price: '100,000',
      accent: AppColors.blue,
      icon: Icons.inventory_2_rounded,
      currency: 'coins',
      count: 5,
      tag: 'BRONZE',
    ),
    Pack(
      name: 'Premium Pack',
      price: '500',
      accent: AppColors.violet,
      icon: Icons.workspace_premium_rounded,
      currency: 'gems',
      count: 11,
      badge: 'POPULAR',
    ),
    Pack(
      name: 'Legendary Pack',
      price: '1,000',
      accent: AppColors.gold,
      icon: Icons.auto_awesome_rounded,
      currency: 'gems',
      count: 1,
      tag: 'ICON',
    ),
    Pack(
      name: 'Special Offer',
      price: '4.99',
      accent: AppColors.red,
      icon: Icons.local_offer_rounded,
      currency: 'gems',
      count: 1,
      tag: 'PG 99',
      badge: '-70%',
      discount: r'$16.99',
    ),
  ];

  // ---- Yutuqlar ----
  static const achievements = <Achievement>[
    Achievement(
      id: 'first_win',
      title: 'First Victory',
      description: 'Win your first match',
      rewardCoins: 50000,
      progress: 1,
      target: 1,
    ),
    Achievement(
      id: 'striker',
      title: 'Striker',
      description: 'Score 10 goals',
      rewardCoins: 100000,
      progress: 7,
      target: 10,
    ),
    Achievement(
      id: 'playmaker',
      title: 'Playmaker',
      description: 'Play 5 matches',
      rewardCoins: 75000,
      progress: 4,
      target: 5,
    ),
    Achievement(
      id: 'rich',
      title: 'Millionaire',
      description: 'Hold 3M coins at once',
      rewardCoins: 50000,
      progress: 1,
      target: 1,
      claimed: true,
    ),
    Achievement(
      id: 'champion',
      title: 'Champion of Europe',
      description: 'Win the UCL final',
      rewardCoins: 500000,
      progress: 0,
      target: 1,
    ),
  ];

  // ---- Karyera ----
  static const careerMatches = 128;
  static const careerGoals = 86;
  static const careerAssists = 52;
  static const careerWins = 92;

  // ---- Jamoa ko'rsatkichlari ----
  static const teamStats = <({String label, double value, Color color})>[
    (label: 'Attack', value: 0.97, color: AppColors.red),
    (label: 'Midfield', value: 0.95, color: AppColors.lime),
    (label: 'Defense', value: 0.94, color: AppColors.blue),
    (label: 'Goalkeeper', value: 0.96, color: AppColors.gold),
  ];
}

```

## `lib/game3d/game_painter.dart`

```dart
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

```

## `lib/game3d/match_game.dart`

```dart
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
    _possession();
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

  void _possession() {
    if (ownerTeam >= 0) {
      final p = _owner()!;
      // Oldinda sirpanib yuradi.
      final ahead = V3(math.sin(p.facing), 0, math.cos(p.facing));
      ball = V3(p.pos.x + ahead.x * 0.55, ballR, p.pos.z + ahead.z * 0.55);
      ballVel = p.vel;
      // Raqib yondashib to'pni olishi mumkin.
      for (final q in players) {
        if (q.team == p.team) continue;
        final d = (q.pos - ball).length;
        final stealP = q.isGk ? 0.5 : 0.32;
        if (d < 0.62 && _rng.nextDouble() < stealP) {
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
    final cx = (ball.x * 0.5).clamp(-22.0, 22.0);
    return Camera3D(
      eye: V3(cx + s, 38, -62),
      target: V3(cx * 1.15, 0, 2),
      fovY: 0.78,
    );
  }
}

extension on V3 {
  V3 copyWith({double? x, double? y, double? z}) =>
      V3(x ?? this.x, y ?? this.y, z ?? this.z);
}

```

## `lib/game3d/match_painter.dart`

```dart
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

```

## `lib/game3d/penalty_game.dart`

```dart
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

```

## `lib/game3d/vec3.dart`

```dart
import 'dart:math' as math;
import 'dart:ui';

/// Oddiy 3D vektor.
class V3 {
  const V3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  static const zero = V3(0, 0, 0);

  V3 operator +(V3 o) => V3(x + o.x, y + o.y, z + o.z);
  V3 operator -(V3 o) => V3(x - o.x, y - o.y, z - o.z);
  V3 operator *(double s) => V3(x * s, y * s, z * s);
  V3 operator -() => V3(-x, -y, -z);

  double dot(V3 o) => x * o.x + y * o.y + z * o.z;

  V3 cross(V3 o) =>
      V3(y * o.z - z * o.y, z * o.x - x * o.z, x * o.y - y * o.x);

  double get length => math.sqrt(dot(this));

  V3 get normalized {
    final l = length;
    return l == 0 ? zero : this * (1 / l);
  }

  V3 lerp(V3 o, double t) => this + (o - this) * t;

  @override
  String toString() =>
      'V3(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})';
}

/// Perspektiv kamera: ko'z nuqtasi, qarash nuqtasi va vertikal ko'rish burchagi.
class Camera3D {
  Camera3D({required this.eye, required this.target, this.fovY = 0.92});

  final V3 eye;
  final V3 target;
  final double fovY;

  late final V3 forward = (target - eye).normalized;
  late final V3 right = const V3(0, 1, 0).cross(forward).normalized;
  late final V3 up = forward.cross(right).normalized;
}

/// 3D nuqtani ekranga proyeksiya qiluvchi va teskarisini hisoblovchi vosita.
class Projector {
  Projector(this.camera, this.size)
      : focal = size.height / (2 * math.tan(camera.fovY / 2));

  final Camera3D camera;
  final Size size;
  final double focal;

  /// Nuqta kamera orqasida bo'lsa `null` qaytadi.
  Offset? project(V3 p) {
    final d = p - camera.eye;
    final cz = d.dot(camera.forward);
    if (cz <= 0.05) return null;
    final cx = d.dot(camera.right);
    final cy = d.dot(camera.up);
    return Offset(
      size.width / 2 + cx / cz * focal,
      size.height / 2 - cy / cz * focal,
    );
  }

  double depthOf(V3 p) => (p - camera.eye).dot(camera.forward);

  /// Berilgan nuqtadagi masshtab: 1 metr necha piksel.
  double scaleAt(V3 p) {
    final cz = depthOf(p);
    return cz <= 0.05 ? 0 : focal / cz;
  }

  /// Ekran nuqtasidan `z = planeZ` tekisligidagi 3D nuqtaga nur tashlash.
  V3 unproject(Offset screen, double planeZ) {
    final dx = (screen.dx - size.width / 2) / focal;
    final dy = -(screen.dy - size.height / 2) / focal;
    final dir = camera.right * dx + camera.up * dy + camera.forward;
    if (dir.z.abs() < 0.0001) return V3(0, 0, planeZ);
    final t = (planeZ - camera.eye.z) / dir.z;
    return camera.eye + dir * t;
  }
}

```

## `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'state/game_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(FodballApp(state: GameState()));
}

class FodballApp extends StatelessWidget {
  const FodballApp({super.key, required this.state, this.home});

  final GameState state;
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return GameStateScope(
      state: state,
      child: MaterialApp(
        title: 'Fodball 3D — Football Legends',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: home ?? const HomeScreen(),
      ),
    );
  }
}

```

## `lib/models/models.dart`

```dart
import 'package:flutter/material.dart';

/// Maydondagi o'yinchi.
@immutable
class Player {
  const Player({
    required this.name,
    required this.position,
    required this.rating,
    required this.number,
    this.alignment = Alignment.center,
    this.color = const Color(0xFF2F6BFF),
    this.flag = const [Color(0xFFFFFFFF), Color(0xFFD52B1E)],
    this.pace = 80,
    this.shooting = 80,
    this.passing = 80,
    this.defending = 80,
  });

  final String name;
  final String position;
  final int rating;
  final int number;

  /// Maydon ichidagi nisbiy joylashuv (-1..1). Zaxira o'yinchilarda noma'lum.
  final Alignment alignment;
  final Color color;

  /// Bayroq ranglari (2 ta halqa rangi).
  final List<Color> flag;

  final int pace;
  final int shooting;
  final int passing;
  final int defending;

  bool get isStarter => alignment != Alignment.center;

  Player copyWith({
    String? position,
    int? rating,
    Alignment? alignment,
    int? pace,
    int? shooting,
    int? passing,
    int? defending,
  }) {
    return Player(
      name: name,
      position: position ?? this.position,
      rating: rating ?? this.rating,
      number: number,
      alignment: alignment ?? this.alignment,
      color: color,
      flag: flag,
      pace: pace ?? this.pace,
      shooting: shooting ?? this.shooting,
      passing: passing ?? this.passing,
      defending: defending ?? this.defending,
    );
  }

  String get initials {
    final parts = name
        .replaceAll('.', '')
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final word = parts.first;
      return word.substring(0, word.length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

/// Futbol klubi.
@immutable
class Club {
  const Club({
    required this.name,
    required this.short,
    required this.crestColors,
  });

  final String name;
  final String short;

  /// Gerb halqasi uchun 2 ta rang.
  final List<Color> crestColors;
}

/// Turnir jadvali qatori.
@immutable
class Standing {
  const Standing({
    required this.club,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    this.isUser = false,
  });

  final Club club;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final bool isUser;

  int get points => won * 3 + drawn;

  Standing copyWith({
    int? played,
    int? won,
    int? drawn,
    int? lost,
    int? goalsFor,
    int? goalsAgainst,
  }) {
    return Standing(
      club: club,
      played: played ?? this.played,
      won: won ?? this.won,
      drawn: drawn ?? this.drawn,
      lost: lost ?? this.lost,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      isUser: isUser,
    );
  }
}

/// Keyingi o'yin haqida.
@immutable
class MatchInfo {
  const MatchInfo({
    required this.competition,
    required this.home,
    required this.away,
    required this.dateLabel,
    required this.timeLabel,
    this.isFinal = false,
  });

  final String competition;
  final Club home;
  final Club away;
  final String dateLabel;
  final String timeLabel;
  final bool isFinal;
}

/// Do'kondagi paket.
@immutable
class Pack {
  const Pack({
    required this.name,
    required this.price,
    required this.accent,
    required this.icon,
    this.currency = 'coins',
    this.count = 1,
    this.tag,
    this.badge,
    this.discount,
  });

  final String name;
  final String price;
  final Color accent;
  final IconData icon;

  /// 'coins' yoki 'gems'.
  final String currency;

  /// Ichidagi kartalar soni.
  final int count;
  final String? tag;
  final String? badge;
  final String? discount;
}

/// Yutuq / missiya.
@immutable
class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.rewardCoins,
    required this.progress,
    required this.target,
    this.claimed = false,
  });

  final String id;
  final String title;
  final String description;
  final int rewardCoins;
  final int progress;
  final int target;
  final bool claimed;

  double get ratio => target == 0 ? 1 : (progress / target).clamp(0.0, 1.0);
  bool get isComplete => progress >= target;

  Achievement copyWith({int? progress, bool? claimed}) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      rewardCoins: rewardCoins,
      progress: progress ?? this.progress,
      target: target,
      claimed: claimed ?? this.claimed,
    );
  }
}

/// Transfer bozoridagi o'yinchi.
@immutable
class TransferTarget {
  const TransferTarget({
    required this.player,
    required this.price,
    required this.sellingClub,
  });

  final Player player;
  final int price;
  final String sellingClub;
}

```

## `lib/screens/achievements_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../state/game_state.dart';
import '../theme/app_colors.dart';

/// Yutuqlar ekrani — missiyalar va sovg'alar.
class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/champions_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.62),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: const Icon(Icons.arrow_back_rounded,
                              size: 17, color: AppColors.text),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Achievements',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (final a in state.achievements)
                    _AchievementRow(
                      title: a.title,
                      description: a.description,
                      progress: a.progress,
                      target: a.target,
                      reward: a.rewardCoins,
                      complete: a.isComplete,
                      claimed: a.claimed,
                      onClaim: a.isComplete && !a.claimed
                          ? () {
                              state.claimAchievement(a.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '+${_format(a.rewardCoins)} coins claimed!',
                                  ),
                                ),
                              );
                            }
                          : null,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _format(int v) {
    if (v >= 1000) return '${(v / 1000).round()}K';
    return '$v';
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.reward,
    required this.complete,
    required this.claimed,
    required this.onClaim,
  });

  final String title;
  final String description;
  final int progress;
  final int target;
  final int reward;
  final bool complete;
  final bool claimed;
  final VoidCallback? onClaim;

  @override
  Widget build(BuildContext context) {
    final ratio = (progress / target).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF16233F).withValues(alpha: 0.8),
            const Color(0xFF0A1120).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: complete
              ? AppColors.lime.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.09),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: (complete ? AppColors.gold : AppColors.blue)
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              complete ? Icons.emoji_events_rounded : Icons.flag_rounded,
              size: 20,
              color: complete ? AppColors.gold : AppColors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: ratio,
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          valueColor: AlwaysStoppedAnimation(
                            complete ? AppColors.lime : AppColors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$progress/$target',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                '+${reward >= 1000 ? '${(reward / 1000).round()}K' : reward}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 5),
              if (claimed)
                const Icon(Icons.check_circle_rounded,
                    size: 20, color: AppColors.lime)
              else
                Material(
                  color: onClaim != null
                      ? AppColors.lime
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: onClaim,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        'CLAIM',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          color: onClaim != null
                              ? const Color(0xFF241A02)
                              : AppColors.muted,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/career_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Karyera ekrani — statistika va mavsum progressi.
class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero_player.png',
            fit: BoxFit.cover,
            alignment: const Alignment(0.5, -0.2),
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const _ScreenHeader(title: 'Player Career'),
                  const SizedBox(height: 14),
                  GlassPanel(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.userHandle,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Level ${state.level} · ${state.userClub.name} Manager',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: state.xp / state.xpMax,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.08),
                            valueColor:
                                const AlwaysStoppedAnimation(AppColors.blue),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'XP ${state.xp} / ${state.xpMax}',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StatTile(label: 'Matches', value: '${state.careerMatches}', icon: Icons.sports_soccer_rounded, color: AppColors.blue),
                      _StatTile(label: 'Wins', value: '${state.careerWins}', icon: Icons.check_circle_rounded, color: AppColors.lime),
                      _StatTile(label: 'Goals', value: '${state.careerGoals}', icon: Icons.sports_soccer_rounded, color: AppColors.gold),
                      _StatTile(label: 'Assists', value: '${state.careerAssists}', icon: Icons.handshake_rounded, color: AppColors.violet),
                      _StatTile(label: 'Trophies', value: '${state.trophies}', icon: Icons.emoji_events_rounded, color: AppColors.red),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GlassPanel(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle('Season Objective'),
                        const SizedBox(height: 10),
                        const Text(
                          'Win the Champions League final',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: state.uclChampion ? 1 : 0.85,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.08),
                            valueColor: AlwaysStoppedAnimation(
                              state.uclChampion ? AppColors.lime : AppColors.gold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.uclChampion ? 'COMPLETED' : '85% — final waiting',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: GlassPanel(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 19, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Umumiy ekran sarlavhasi (orqaga tugma + sarlavha).
class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: const Icon(Icons.arrow_back_rounded,
                size: 17, color: AppColors.text),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

```

## `lib/screens/champions_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../state/game_state.dart';
import '../theme/app_colors.dart';

/// Chempionlik ekrani — kubok va tantanali fon.
class ChampionsScreen extends StatelessWidget {
  const ChampionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/champions_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.78),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.14),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.4),
                        blurRadius: 40,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 72,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'CHAMPIONS!',
                  style: TextStyle(
                    fontSize: 46,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    letterSpacing: -0.5,
                    color: AppColors.gold,
                    shadows: [
                      Shadow(color: Colors.black54, blurRadius: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.userClub.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
                  ),
                ),
                const Spacer(),
                Material(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 13),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.chevron_right_rounded,
                              size: 18, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/game_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../game3d/game_painter.dart';
import '../game3d/penalty_game.dart';
import '../theme/app_colors.dart';

/// 3D penalti o'yini ekrani.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late final PenaltyGame _game = PenaltyGame();
  late final GamePainter _painter = GamePainter(_game);
  late final Ticker _ticker;
  Duration _last = Duration.zero;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1000000.0;
    _last = elapsed;
    if (dt > 0 && dt < 0.25) _game.tick(dt);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _game.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _exitToMenu() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(child: CustomPaint(painter: _painter)),

          // Dekorativ HUD (tugmalarni o'z ichiga olmaydi).
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _game,
              builder: (context, _) => _Hud(game: _game),
            ),
          ),

          // O'yin kiritish qatlami.
          LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (d) => _game.tapShoot(d.localPosition, size),
                onPanStart: (d) => _game.beginAim(d.localPosition, size),
                onPanUpdate: (d) => _game.updateAim(d.localPosition, size),
                onPanEnd: (_) => _game.releaseShot(),
                onPanCancel: () => _game.releaseShot(),
              );
            },
          ),

          // Boshqaruv tugmalari.
          Positioned.fill(
            child: SafeArea(
              minimum: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _RoundButton(
                      icon: Icons.exit_to_app_rounded,
                      label: 'EXIT',
                      onTap: _exitToMenu,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // O'yin tugagan ekran.
          AnimatedBuilder(
            animation: _game,
            builder: (context, _) => _GameOverOverlay(
              game: _game,
              onClub: _exitToMenu,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HUD
// -----------------------------------------------------------------------------

class _Hud extends StatelessWidget {
  const _Hud({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(10),
      child: Stack(
        children: [
          const Positioned(left: 0, top: 0, child: _Brand()),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(child: _Scoreboard(game: game)),
          ),
          Positioned(left: 0, bottom: 0, child: _Hint(game: game)),
          Positioned(right: 0, bottom: 0, child: _PowerMeter(game: game)),
          Positioned.fill(child: Center(child: _ResultBanner(game: game))),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.lime,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sports_soccer_rounded,
              size: 15,
              color: AppColors.bgDeep,
            ),
          ),
          const SizedBox(width: 7),
          const Text(
            'FODBALL',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.6,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.lime.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '3D',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                color: AppColors.lime,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Metric(label: 'GOALS', value: '${game.goals}', color: AppColors.lime),
          const _Divider(),
          _Metric(
            label: 'SHOT',
            value: '${game.shotsTaken}/${PenaltyGame.totalShots}',
            color: AppColors.text,
          ),
          const _Divider(),
          _Metric(
            label: 'STREAK',
            value: '×${game.streak}',
            color: game.streak > 0 ? AppColors.gold : AppColors.muted,
          ),
          const SizedBox(width: 12),
          _ShotDots(history: game.history),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white.withValues(alpha: 0.10),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
            color: AppColors.muted.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            height: 1,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ShotDots extends StatelessWidget {
  const _ShotDots({required this.history});

  final List<String> history;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < PenaltyGame.totalShots; i++)
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i < history.length
                  ? switch (history[i]) {
                      'goal' => AppColors.lime,
                      'save' => AppColors.gold,
                      _ => AppColors.red,
                    }
                  : Colors.white.withValues(alpha: 0.16),
            ),
          ),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    final first = game.shotsTaken == 0;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: first ? 1 : 0.35,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.touch_app_rounded, size: 14, color: AppColors.lime),
            const SizedBox(width: 6),
            Text(
              first
                  ? 'Drag to aim · release to shoot'
                  : 'Aim for the corners',
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PowerMeter extends StatelessWidget {
  const _PowerMeter({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase != ShotPhase.aiming) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt_rounded, size: 14, color: AppColors.gold),
          const SizedBox(height: 5),
          Container(
            width: 9,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: game.power.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [AppColors.lime, AppColors.gold, AppColors.red],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase != ShotPhase.result || game.lastResult == null) {
      return const SizedBox.shrink();
    }
    final result = game.lastResult!;
    final color = switch (result) {
      'GOAL!' => AppColors.lime,
      'SAVED' => AppColors.gold,
      _ => AppColors.red,
    };
    final fade = (game.resultTimer / 0.4).clamp(0.0, 1.0);
    final pop = (1.35 - (game.resultTimer / 1.6) * 0.35).clamp(1.0, 1.35);

    return Opacity(
      opacity: fade,
      child: Transform.scale(
        scale: pop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              result,
              style: TextStyle(
                fontSize: 46,
                height: 1,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.2,
                color: color,
                shadows: [
                  Shadow(
                    color: color.withValues(alpha: 0.55),
                    blurRadius: 26,
                  ),
                ],
              ),
            ),
            if (result == 'GOAL!' && game.streak > 1) ...[
              const SizedBox(height: 6),
              Text(
                'STREAK ×${game.streak}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.2,
                  color: AppColors.text,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: AppColors.lime),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// O'yin tugadi
// -----------------------------------------------------------------------------

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.game, required this.onClub});

  final PenaltyGame game;
  final VoidCallback onClub;

  @override
  Widget build(BuildContext context) {
    if (!game.isOver) return const IgnorePointer(child: SizedBox.shrink());

    final accuracy = game.shotsTaken == 0
        ? 0
        : (game.goals / game.shotsTaken * 100).round();

    return Container(
      color: Colors.black.withValues(alpha: 0.62),
      alignment: Alignment.center,
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF16233F), Color(0xFF0A1120)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.lime.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.lime.withValues(alpha: 0.18),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FULL TIME',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${game.goals} / ${PenaltyGame.totalShots}',
              style: const TextStyle(
                fontSize: 46,
                height: 1,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              accuracy >= 60 ? 'Striker of the match 🔥' : 'Keep practising!',
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatChip(label: 'ACCURACY', value: '$accuracy%'),
                const SizedBox(width: 8),
                _StatChip(label: 'BEST STREAK', value: '×${game.bestStreak}'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'PLAY AGAIN',
                    icon: Icons.replay_rounded,
                    filled: true,
                    onTap: game.restart,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    label: 'MENU',
                    icon: Icons.home_rounded,
                    filled: false,
                    onTap: onClub,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.lime : Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: filled
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15,
                color: filled ? AppColors.bgDeep : AppColors.text,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  color: filled ? AppColors.bgDeep : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

## `lib/screens/home_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'achievements_screen.dart';
import 'career_screen.dart';
import 'match_screen.dart';
import 'settings_screen.dart';
import 'store_screen.dart';
import 'team_screen.dart';
import 'tournaments_screen.dart';
import 'training_screen.dart';
import 'transfers_screen.dart';

/// Asosiy menyu — Football Legends uslubida.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF02050C).withValues(alpha: 0.55),
                  const Color(0xFF02050C).withValues(alpha: 0.25),
                  const Color(0xFF02050C).withValues(alpha: 0.82),
                ],
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 1150;
                final content = wide
                    ? _WideLayout(onPlay: () => _startMatch(context))
                    : _NarrowLayout(onPlay: () => _startMatch(context));
                return Column(
                  children: [
                    const _TopBar(),
                    Expanded(child: content),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startMatch(BuildContext context) {
    pushScreen(context, const MatchScreen(match: MockData.nextMatch));
  }
}

// -----------------------------------------------------------------------------
// Yuqori panel
// -----------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
      child: AnimatedBuilder(
        animation: state,
        builder: (context, _) => LayoutBuilder(
          builder: (context, constraints) {
            final showProfile = constraints.maxWidth >= 780;
            return Row(
              children: [
                const _Logo(),
                if (showProfile) ...[
                  const SizedBox(width: 14),
                  const _Profile(),
                  const SizedBox(width: 14),
                  _LevelBadge(
                      level: state.level, xp: state.xp, xpMax: state.xpMax),
                ],
                const Spacer(),
                const Flexible(child: CurrencyBar()),
                const SizedBox(width: 10),
                _IconBadge(
                  icon: Icons.notifications_rounded,
                  count: state.notifications,
                  onTap: () {
                    state.clearNotifications();
                    pushScreen(context, const AchievementsScreen());
                  },
                ),
                const SizedBox(width: 8),
                _IconBadge(
                  icon: Icons.settings_rounded,
                  onTap: () => pushScreen(context, const SettingsScreen()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.5)),
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.gold,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FOOTBALL',
              style: TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: AppColors.text,
              ),
            ),
            Text(
              'LEGENDS',
              style: TextStyle(
                fontSize: 14,
                height: 1.1,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: AppColors.gold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lime.withValues(alpha: 0.5),
                  AppColors.blue.withValues(alpha: 0.5),
                ],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              image: const DecorationImage(
                image: AssetImage('assets/images/hero_player.png'),
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.userName,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Manager',
                style: TextStyle(fontSize: 9.5, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(width: 8),
          ClubCrest(club: state.userClub, size: 28),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level, required this.xp, required this.xpMax});

  final int level;
  final int xp;
  final int xpMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'LV. $level',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (xp / xpMax).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.blue, Color(0xFF4DE1FF)],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'XP ${_format(xp)} / ${_format(xpMax)}',
              style: const TextStyle(fontSize: 8.5, color: AppColors.muted),
            ),
          ],
        ),
      ],
    );
  }

  static String _format(int v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return '$v';
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, this.count = 0, this.onTap});

  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 17, color: AppColors.text),
            if (count > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 13, minHeight: 13),
                  child: Center(
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 7.5,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Chap menyu
// -----------------------------------------------------------------------------

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.highlighted = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool highlighted;
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem(
        title: 'Career Mode',
        subtitle: 'Build your legacy',
        icon: Icons.sports_soccer_rounded,
        onTap: () => pushScreen(context, const CareerScreen()),
        highlighted: true,
      ),
      _MenuItem(
        title: 'Tournaments',
        subtitle: 'Win prestigious cups',
        icon: Icons.emoji_events_rounded,
        onTap: () => pushScreen(context, const TournamentsScreen()),
      ),
      _MenuItem(
        title: 'Play Match',
        subtitle: 'Quick & Online',
        icon: Icons.play_circle_rounded,
        onTap: onPlay,
      ),
      _MenuItem(
        title: 'Store',
        subtitle: 'Get amazing rewards',
        icon: Icons.shopping_cart_rounded,
        onTap: () => pushScreen(context, const StoreScreen()),
      ),
      _MenuItem(
        title: 'My Club',
        subtitle: 'Manage your team',
        icon: Icons.bar_chart_rounded,
        onTap: () => pushScreen(context, const TeamScreen()),
      ),
      _MenuItem(
        title: 'Settings',
        subtitle: 'Customize game',
        icon: Icons.settings_rounded,
        onTap: () => pushScreen(context, const SettingsScreen()),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _MenuButton(item: item),
          ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.item});

  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    final highlight = item.highlighted;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: highlight
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFD23F), Color(0xFFF5A623)],
                  )
                : null,
            color: highlight ? null : const Color(0xFF0B1426).withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: highlight
                  ? AppColors.gold
                  : Colors.white.withValues(alpha: 0.10),
            ),
            boxShadow: highlight
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.3),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: highlight
                      ? Colors.black.withValues(alpha: 0.2)
                      : item.title == 'Play Match'
                          ? AppColors.gold.withValues(alpha: 0.18)
                          : Colors.white.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: highlight
                      ? const Color(0xFF241A02)
                      : item.title == 'Play Match'
                          ? AppColors.gold
                          : AppColors.lime,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: highlight ? const Color(0xFF241A02) : AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: highlight
                            ? const Color(0xFF241A02).withValues(alpha: 0.75)
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: highlight
                    ? const Color(0xFF241A02)
                    : Colors.white.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Keng layout (desktop / planshet)
// -----------------------------------------------------------------------------

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 262,
                  child: _SideMenu(onPlay: onPlay),
                ),
                const SizedBox(width: 14),
                const Expanded(child: _HeroPanel()),
                const SizedBox(width: 14),
                const SizedBox(width: 316, child: _RightColumn()),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const _FeatureCards(),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Column(
        children: [
          _SideMenu(onPlay: onPlay),
          const SizedBox(height: 12),
          const SizedBox(height: 250, child: _HeroPanel()),
          const SizedBox(height: 12),
          const SizedBox(height: 240, child: _NextMatchCard()),
          const SizedBox(height: 12),
          const SizedBox(height: 260, child: _StandingsCard()),
          const SizedBox(height: 12),
          const _FeatureCards(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Markaziy hero
// -----------------------------------------------------------------------------

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/hero_player.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0.35, -0.3),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF02050C).withValues(alpha: 0.75),
                    const Color(0xFF02050C).withValues(alpha: 0.1),
                    const Color(0xFF02050C).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 26,
              bottom: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DREAM BIG',
                    style: TextStyle(
                      fontSize: 40,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 18),
                      ],
                    ),
                  ),
                  Text(
                    'ACHIEVE MORE',
                    style: TextStyle(
                      fontSize: 40,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontStyle: FontStyle.italic,
                      color: AppColors.gold,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// O'ng ustun: Next Match + jadval
// -----------------------------------------------------------------------------

class _RightColumn extends StatelessWidget {
  const _RightColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: _NextMatchCard()),
        SizedBox(height: 12),
        Expanded(child: _StandingsCard()),
      ],
    );
  }
}

class _NextMatchCard extends StatelessWidget {
  const _NextMatchCard();

  @override
  Widget build(BuildContext context) {
    final match = MockData.nextMatch;
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Next Match',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _MatchClub(club: match.home)),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: AppColors.muted,
                ),
              ),
              Expanded(child: _MatchClub(club: match.away)),
            ],
          ),
          const SizedBox(height: 6),
          const Icon(Icons.emoji_events_outlined,
              size: 15, color: AppColors.blue),
          const SizedBox(height: 2),
          Center(
            child: Text(
              match.competition,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.6,
                color: AppColors.blue,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month_rounded,
                  size: 13, color: AppColors.muted),
              const SizedBox(width: 5),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${match.dateLabel}  |  ${match.timeLabel}',
                    style: const TextStyle(fontSize: 11, color: AppColors.muted),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _StartMatchButton(
            onTap: () => pushScreen(
              context,
              const MatchScreen(match: MockData.nextMatch),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchClub extends StatelessWidget {
  const _MatchClub({required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClubCrest(club: club, size: 46),
        const SizedBox(height: 6),
        Text(
          club.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _StartMatchButton extends StatelessWidget {
  const _StartMatchButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.gold,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.35),
                blurRadius: 14,
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Start Match',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF241A02),
                ),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: Color(0xFF241A02),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StandingsCard extends StatelessWidget {
  const _StandingsCard();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: AnimatedBuilder(
        animation: state,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionTitle('League Standings'),
            const SizedBox(height: 8),
            const Row(
              children: [
                SizedBox(width: 18, child: _Head('#')),
                Expanded(child: _Head('Club')),
                SizedBox(width: 30, child: _Head('P', align: TextAlign.center)),
                SizedBox(width: 30, child: _Head('Pts', align: TextAlign.right)),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < state.table.length; i++)
                      _StandingRow(
                        index: i + 1,
                        standing: state.table[i],
                      ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'LALIGA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head(this.text, {this.align = TextAlign.left});

  final String text;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: const TextStyle(
        fontSize: 9.5,
        fontWeight: FontWeight.w800,
        color: AppColors.muted,
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  const _StandingRow({required this.index, required this.standing});

  final int index;
  final Standing standing;

  @override
  Widget build(BuildContext context) {
    final isUser = standing.isUser;
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.blue.withValues(alpha: 0.28)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
        border: isUser
            ? Border.all(color: AppColors.blue.withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text(
              '$index',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.muted,
              ),
            ),
          ),
          ClubCrest(club: standing.club, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              standing.club.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isUser ? FontWeight.w900 : FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${standing.played}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11.5, color: AppColors.text),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${standing.points}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w900,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Pastki kartalar
// -----------------------------------------------------------------------------

class _FeatureCards extends StatelessWidget {
  const _FeatureCards();

  @override
  Widget build(BuildContext context) {
    const height = 118.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: _FeatureCard(
              title: 'Player Career',
              subtitle: 'Grow into a legend',
              image: 'assets/images/hero_player.png',
              icon: Icons.person_rounded,
              onTap: () => pushScreen(context, const CareerScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Transfers',
              subtitle: 'Buy & Sell Players',
              image: 'assets/images/stadium_bg.png',
              icon: Icons.handshake_rounded,
              onTap: () => pushScreen(context, const TransfersScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Training',
              subtitle: 'Improve Your Team',
              image: 'assets/images/stadium_bg.png',
              icon: Icons.sports_rounded,
              onTap: () => pushScreen(context, const TrainingScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Achievements',
              subtitle: 'Complete Missions',
              image: 'assets/images/champions_bg.png',
              icon: Icons.military_tech_rounded,
              badge: '12',
              onTap: () => pushScreen(context, const AchievementsScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: _FeatureCard(
              title: 'CHAMPIONS\nLEAGUE',
              subtitle: 'The ultimate stage',
              image: 'assets/images/champions_bg.png',
              icon: Icons.emoji_events_rounded,
              onTap: () => pushScreen(context, const TournamentsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String subtitle;
  final String image;
  final IconData icon;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(image, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                    ),
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          fontSize: 9,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(icon, size: 15, color: AppColors.lime),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12.5,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

## `lib/screens/match_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../data/mock_data.dart';
import '../game3d/match_game.dart';
import '../game3d/match_painter.dart';
import '../game3d/vec3.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'champions_screen.dart';

/// To'liq 3D match ekrani: joystick, PASS/SHOOT/SPRINT, hisob, minimap.
class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key, required this.match});

  final MatchInfo match;

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen>
    with SingleTickerProviderStateMixin {
  late final MatchGame _game;
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  bool _rewardsApplied = false;
  bool _championsShown = false;
  bool _gameReady = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_gameReady) return;
    _gameReady = true;
    final state = GameStateScope.of(context);
    _game = MatchGame(
      homeNames: [
        for (final p in state.squad)
          (
            name: p.name,
            number: p.number,
            pace: p.pace,
            shooting: p.shooting,
            passing: p.passing,
          ),
      ],
      awayNames: _awayRoster(),
    );
    _ticker = createTicker(_onTick)..start();
  }

  List<({String name, int number, int pace, int shooting, int passing})>
      _awayRoster() {
    final pool = MockData.packPool;
    return [
      for (var i = 0; i < 11; i++)
        (
          name: pool[i % pool.length].name,
          number: pool[i % pool.length].number,
          pace: pool[i % pool.length].pace,
          shooting: pool[i % pool.length].shooting,
          passing: pool[i % pool.length].passing,
        ),
    ];
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1000000.0;
    _last = elapsed;
    if (dt > 0 && dt < 0.25) _game.tick(dt);
    if (_game.isFullTime && !_rewardsApplied) _applyResult();
    if (_game.isFullTime &&
        widget.match.isFinal &&
        _game.scoreHome > _game.scoreAway &&
        !_championsShown) {
      _championsShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChampionsScreen()),
        );
      });
    }
  }

  void _applyResult() {
    _rewardsApplied = true;
    final state = GameStateScope.of(context);
    state.recordMatchResult(
      won: _game.scoreHome > _game.scoreAway,
      draw: _game.scoreHome == _game.scoreAway,
      goalsFor: _game.scoreHome,
      goalsAgainst: _game.scoreAway,
      isFinal: widget.match.isFinal,
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _game.isFullTime,
      child: Scaffold(
        backgroundColor: AppColors.bgDeep,
        body: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: CustomPaint(painter: MatchPainter(_game)),
            ),
            _Hud(game: _game, match: widget.match),
            const _JoystickLayer(),
            _Buttons(
              onPass: _game.pass,
              onShoot: _game.shoot,
              onSprint: (v) => _game.setSprint(v),
            ),
            Positioned(
              top: 8,
              right: 10,
              child: _PauseButton(onPause: () => _showPause(context)),
            ),
            AnimatedBuilder(
              animation: _game,
              builder: (context, _) =>
                  _FullTimeOverlay(game: _game, match: widget.match),
            ),
          ],
        ),
      ),
    );
  }

  void _showPause(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0B1426),
        title: const Text('Pause',
            style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w900)),
        content: const Text('Match is waiting for you.',
            style: TextStyle(color: AppColors.muted)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('RESUME',
                style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.w900)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('QUIT',
                style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HUD
// -----------------------------------------------------------------------------

class _Hud extends StatelessWidget {
  const _Hud({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: game,
      builder: (context, _) => Stack(
        children: [
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Center(child: _Scoreboard(game: game, match: match)),
          ),
          Positioned.fill(child: Center(child: _Banner(game: game))),
          Positioned(
            left: 12,
            bottom: 12,
            child: _Minimap(game: game),
          ),
        ],
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClubCrest(club: match.home, size: 22),
          const SizedBox(width: 8),
          Text(
            match.home.short,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${game.scoreHome} - ${game.scoreAway}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            match.away.short,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 8),
          ClubCrest(club: match.away, size: 22),
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${game.clockMinute.toString().padLeft(2, '0')}:${game.clockSecond.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.game});

  final MatchGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase == MatchPhase.goal) {
      final userScored = game.lastScorerTeam == 0;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'GOAL!',
            style: TextStyle(
              fontSize: 54,
              height: 1,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: userScored ? AppColors.lime : AppColors.red,
              shadows: [
                Shadow(
                  color: (userScored ? AppColors.lime : AppColors.red)
                      .withValues(alpha: 0.6),
                  blurRadius: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            game.lastScorer,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
            ),
          ),
        ],
      );
    }
    if (game.phase == MatchPhase.kickoff) {
      return const Text(
        'KICK OFF',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          letterSpacing: 3,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black87, blurRadius: 12)],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _Minimap extends StatelessWidget {
  const _Minimap({required this.game});

  final MatchGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(painter: _MinimapPainter(game)),
      ),
    );
  }
}

class _MinimapPainter extends CustomPainter {
  const _MinimapPainter(this.game);

  final MatchGame game;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0F3B24),
    );
    final line = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawRect(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      line,
    );
    canvas.drawLine(
      Offset(size.width / 2, 2),
      Offset(size.width / 2, size.height - 2),
      line,
    );

    Offset map(V3 p) => Offset(
          (p.x / (MatchGame.pitchL * 2) + 0.5) * size.width,
          (p.z / (MatchGame.pitchW * 2) + 0.5) * size.height,
        );

    for (final p in game.players) {
      canvas.drawCircle(
        map(p.pos),
        p.team == 0 ? 2.4 : 2.2,
        Paint()
          ..color = p.team == 0
              ? Colors.white
              : const Color(0xFFFF4D5E).withValues(alpha: 0.95),
      );
    }
    canvas.drawCircle(
      map(game.ball),
      2.0,
      Paint()..color = AppColors.gold,
    );
  }

  @override
  bool shouldRepaint(covariant _MinimapPainter oldDelegate) => true;
}

// -----------------------------------------------------------------------------
// Joystick
// -----------------------------------------------------------------------------

class _JoystickLayer extends StatefulWidget {
  const _JoystickLayer();

  @override
  State<_JoystickLayer> createState() => _JoystickLayerState();
}

class _JoystickLayerState extends State<_JoystickLayer> {
  Offset _center = Offset.zero;
  Offset _knob = Offset.zero;
  bool _active = false;

  static const double _radius = 44;

  MatchGame get _game =>
      context.findAncestorStateOfType<_MatchScreenState>()!._game;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.72,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (d) {
          setState(() {
            _active = true;
            _center = d.localPosition;
            _knob = d.localPosition;
          });
        },
        onPanUpdate: (d) {
          final delta = d.localPosition - _center;
          final dist = delta.distance;
          final clamped =
              dist > _radius ? _center + delta / dist * _radius : d.localPosition;
          setState(() => _knob = clamped);
          final v = (clamped - _center) / _radius;
          _game.setJoystick(v.dx, v.dy);
        },
        onPanEnd: (_) => _reset(),
        onPanCancel: _reset,
        child: Stack(
          children: [
            if (_active) ...[
              Positioned(
                left: _center.dx - _radius - 14,
                top: _center.dy - _radius - 14,
                child: Container(
                  width: (_radius + 14) * 2,
                  height: (_radius + 14) * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _knob.dx - 22,
                top: _knob.dy - 22,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.25),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                  ),
                  child: const Icon(
                    Icons.sports_soccer_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ] else
              Positioned(
                left: 22,
                bottom: 96,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: const Icon(
                    Icons.gamepad_rounded,
                    size: 24,
                    color: Colors.white38,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _reset() {
    setState(() => _active = false);
    _game.setJoystick(0, 0);
  }
}

// -----------------------------------------------------------------------------
// Tugmalar
// -----------------------------------------------------------------------------

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.onPass,
    required this.onShoot,
    required this.onSprint,
  });

  final VoidCallback onPass;
  final VoidCallback onShoot;
  final ValueChanged<bool> onSprint;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 14,
      child: SizedBox(
        width: 190,
        height: 170,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: _ActionRound(
                label: 'Shoot',
                icon: Icons.sports_soccer_rounded,
                size: 62,
                color: AppColors.red,
                onTap: onShoot,
              ),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: _ActionRound(
                label: 'Pass',
                icon: Icons.call_made_rounded,
                size: 56,
                color: AppColors.blue,
                onTap: onPass,
              ),
            ),
            Positioned(
              right: 4,
              bottom: 0,
              child: _SprintButton(
                label: 'Sprint',
                icon: Icons.bolt_rounded,
                size: 60,
                color: AppColors.lime,
                onChanged: onSprint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionRound extends StatelessWidget {
  const _ActionRound({
    required this.label,
    required this.icon,
    required this.size,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.22),
                border: Border.all(color: color.withValues(alpha: 0.85), width: 1.6),
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 12),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: size * 0.42),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: 0.85),
            shadows: const [Shadow(color: Colors.black87, blurRadius: 4)],
          ),
        ),
      ],
    );
  }
}

class _SprintButton extends StatefulWidget {
  const _SprintButton({
    required this.label,
    required this.icon,
    required this.size,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final double size;
  final Color color;
  final ValueChanged<bool> onChanged;

  @override
  State<_SprintButton> createState() => _SprintButtonState();
}

class _SprintButtonState extends State<_SprintButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() => _down = true);
            widget.onChanged(true);
          },
          onTapUp: (_) {
            setState(() => _down = false);
            widget.onChanged(false);
          },
          onTapCancel: () {
            setState(() => _down = false);
            widget.onChanged(false);
          },
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _down
                  ? widget.color.withValues(alpha: 0.85)
                  : widget.color.withValues(alpha: 0.22),
              border: Border.all(
                color: widget.color.withValues(alpha: 0.85),
                width: 1.6,
              ),
            ),
            child: Icon(
              widget.icon,
              color: _down ? const Color(0xFF241A02) : Colors.white,
              size: widget.size * 0.42,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: 0.85),
            shadows: const [Shadow(color: Colors.black87, blurRadius: 4)],
          ),
        ),
      ],
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({required this.onPause});

  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPause,
        customBorder: const CircleBorder(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: const Icon(Icons.pause_rounded, size: 18, color: Colors.white),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FULL TIME
// -----------------------------------------------------------------------------

class _FullTimeOverlay extends StatelessWidget {
  const _FullTimeOverlay({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    if (!game.isFullTime) return const SizedBox.shrink();
    final won = game.scoreHome > game.scoreAway;
    final draw = game.scoreHome == game.scoreAway;
    return Container(
      color: Colors.black.withValues(alpha: 0.68),
      alignment: Alignment.center,
      child: GlassPanel(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        radius: 24,
        child: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'FULL TIME',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClubCrest(club: match.home, size: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${game.scoreHome} - ${game.scoreAway}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ClubCrest(club: match.away, size: 40),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                won ? 'VICTORY!' : (draw ? 'DRAW' : 'DEFEAT'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: won ? AppColors.lime : (draw ? AppColors.gold : AppColors.red),
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RewardChip(icon: Icons.monetization_on_rounded, label: 'COINS EARNED'),
                  SizedBox(width: 10),
                  _RewardChip(icon: Icons.bolt_rounded, label: 'XP EARNED'),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Text(
                            'HOME',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardChip extends StatelessWidget {
  const _RewardChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.gold),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/settings_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Sozlamalar ekrani.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sound = true;
  bool _haptics = true;
  bool _notifications = true;
  double _matchLength = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.62),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            size: 17, color: AppColors.text),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GlassPanel(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      _SwitchTile(
                        title: 'Sound',
                        subtitle: 'Crowd and stadium effects',
                        icon: Icons.volume_up_rounded,
                        value: _sound,
                        onChanged: (v) => setState(() => _sound = v),
                      ),
                      _Divider(),
                      _SwitchTile(
                        title: 'Haptics',
                        subtitle: 'Vibration on goals and shots',
                        icon: Icons.vibration_rounded,
                        value: _haptics,
                        onChanged: (v) => setState(() => _haptics = v),
                      ),
                      _Divider(),
                      _SwitchTile(
                        title: 'Notifications',
                        subtitle: 'Match and reward reminders',
                        icon: Icons.notifications_rounded,
                        value: _notifications,
                        onChanged: (v) => setState(() => _notifications = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GlassPanel(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Match length',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      Slider(
                        value: _matchLength,
                        min: 60,
                        max: 300,
                        divisions: 4,
                                    label: '${_matchLength.round()}s',
                        onChanged: (v) => setState(() => _matchLength = v),
                      ),
                      Text(
                        'A match lasts about ${_matchLength.round()} seconds of real time',
                        style:
                            const TextStyle(fontSize: 11, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GlassPanel(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Fodball 3D · Football Legends\n'
                        'Built with Flutter — own 3D engine, no external packages.\n'
                        'Version 2.0.0',
                        style: TextStyle(fontSize: 11.5, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.white.withValues(alpha: 0.07),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.lime),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/store_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Do'kon — paketlar, o'yinchilar, valyuta.
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _tab = 0;
  Player? _opened;

  static const _tabs = ['Packs', 'Players', 'Coins', 'Premium'];

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.6),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => Column(
                children: [
                  _StoreHeader(tab: _tab, onTab: (i) => setState(() => _tab = i)),
                  Expanded(
                    child: switch (_tab) {
                      0 => _packsTab(state),
                      1 => _playersTab(state),
                      2 => _coinsTab(state),
                      _ => _premiumTab(state),
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_opened != null) _PackReveal(player: _opened!, onClose: () => setState(() => _opened = null)),
        ],
      ),
    );
  }

  Widget _packsTab(GameState state) {
    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.72,
      children: [
        for (final pack in MockData.packs)
          _PackCard(
            pack: pack,
            enabled: _canAfford(state, pack),
            onBuy: () => _buyPack(state, pack),
          ),
      ],
    );
  }

  bool _canAfford(GameState state, Pack pack) {
    final price = int.tryParse(pack.price.replaceAll(',', '')) ?? 0;
    return pack.currency == 'coins' ? state.coins >= price : state.gems >= price;
  }

  void _buyPack(GameState state, Pack pack) {
    final price = int.tryParse(pack.price.replaceAll(',', '')) ?? 0;
    final ok = pack.currency == 'coins'
        ? state.spendCoins(price)
        : state.spendGems(price);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough currency!')),
      );
      return;
    }
    setState(() => _opened = state.openPack());
  }

  Widget _playersTab(GameState state) {
    final all = [...state.packPlayers, ...state.reserves];
    if (all.isEmpty) {
      return const Center(
        child: Text(
          'Open packs to get new players',
          style: TextStyle(color: AppColors.muted, fontSize: 14),
        ),
      );
    }
    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 6 : 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.7,
      children: [
        for (final p in all) PlayerCard(player: p),
      ],
    );
  }

  Widget _coinsTab(GameState state) {
    const offers = [
      (amount: 100000, price: '99'),
      (amount: 500000, price: '399'),
      (amount: 1200000, price: '799'),
      (amount: 3250000, price: '1699'),
    ];
    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: [
        for (final o in offers)
          GlassPanel(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on_rounded,
                    size: 34, color: AppColors.gold),
                const SizedBox(height: 8),
                Text(
                  '${(o.amount / 1000).round()}K',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                Material(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => state.addCoins(o.amount),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        '\$${o.price}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF241A02),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _premiumTab(GameState state) {
    return Center(
      child: GlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.workspace_premium_rounded,
                size: 44, color: AppColors.violet),
            const SizedBox(height: 12),
            const Text(
              'LEGENDARY PASS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Exclusive packs, no ads, daily gems',
              style: TextStyle(fontSize: 12.5, color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            Material(
              color: AppColors.violet,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: () => state.addGems(100),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  child: const Text(
                    'ACTIVATE TRIAL  +100 GEMS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreHeader extends StatelessWidget {
  const _StoreHeader({required this.tab, required this.onTab});

  final int tab;
  final ValueChanged<int> onTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 12, 6),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  size: 17, color: AppColors.text),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Store',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < _StoreScreenState._tabs.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Material(
                          color: i == tab
                              ? AppColors.blue
                              : Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(999),
                          child: InkWell(
                            onTap: () => onTab(i),
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: i == tab
                                      ? Colors.transparent
                                      : Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: Text(
                                _StoreScreenState._tabs[i],
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w900,
                                  color: i == tab
                                      ? Colors.white
                                      : AppColors.muted,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const CurrencyBar(compact: true),
        ],
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  const _PackCard({
    required this.pack,
    required this.enabled,
    required this.onBuy,
  });

  final Pack pack;
  final bool enabled;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              pack.accent.withValues(alpha: 0.32),
              const Color(0xFF0A1120),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: pack.accent.withValues(alpha: 0.45)),
        ),
        child: Stack(
          children: [
            if (pack.badge != null)
              Positioned(
                top: 10,
                right: -26,
                child: Transform.rotate(
                  angle: 0.6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 4),
                    color: pack.badge == 'POPULAR' ? AppColors.blue : AppColors.red,
                    child: Text(
                      pack.badge!,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Spacer(),
                  Icon(pack.icon, size: 52, color: pack.accent),
                  if (pack.tag != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      pack.tag!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: pack.accent,
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    pack.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'x${pack.count} players',
                    style: const TextStyle(fontSize: 10, color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  Material(
                    color: enabled ? pack.accent : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: enabled ? onBuy : null,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              pack.currency == 'coins'
                                  ? Icons.monetization_on_rounded
                                  : Icons.diamond_rounded,
                              size: 14,
                              color: enabled
                                  ? const Color(0xFF0A0F1E)
                                  : AppColors.muted,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  pack.price,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w900,
                                    color: enabled
                                        ? const Color(0xFF0A0F1E)
                                        : AppColors.muted,
                                  ),
                                ),
                              ),
                            ),
                            if (pack.discount != null) ...[
                              const SizedBox(width: 5),
                              Text(
                                pack.discount!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xFF0A0F1E),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pack ochilganda chiqqan o'yinchi kartasi.
class _PackReveal extends StatelessWidget {
  const _PackReveal({required this.player, required this.onClose});

  final Player player;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 450),
            builder: (context, t, child) {
              return Transform.scale(
                scale: 0.6 + t * 0.4,
                child: Opacity(opacity: t, child: child),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.35),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: PlayerCard(player: player, width: 150),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'NEW PLAYER!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 14),
          Material(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 11),
                child: const Text(
                  'COLLECT',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF241A02),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/team_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Formatssiyalar: pozitsiya -> maydondagi joylashuv.
const formations = <String, Map<String, Alignment>>{
  '4-3-3': {
    'GK': Alignment(0, 0.94),
    'LB': Alignment(-0.78, 0.6),
    'CB': Alignment(-0.26, 0.68),
    'RB': Alignment(0.78, 0.6),
    'CM': Alignment(-0.55, 0.16),
    'LW': Alignment(-0.78, -0.62),
    'ST': Alignment(0, -0.8),
    'RW': Alignment(0.78, -0.62),
  },
  '4-4-2': {
    'GK': Alignment(0, 0.94),
    'LB': Alignment(-0.78, 0.6),
    'CB': Alignment(-0.28, 0.68),
    'RB': Alignment(0.78, 0.6),
    'LM': Alignment(-0.8, 0.05),
    'CM': Alignment(-0.27, 0.18),
    'RM': Alignment(0.8, 0.05),
    'ST': Alignment(-0.2, -0.75),
  },
  '3-5-2': {
    'GK': Alignment(0, 0.94),
    'CB': Alignment(-0.5, 0.68),
    'LM': Alignment(-0.82, 0.05),
    'CM': Alignment(-0.42, 0.15),
    'RM': Alignment(0.82, 0.05),
    'ST': Alignment(-0.2, -0.75),
  },
};

/// "My Team" ekrani — eFootball uslubida tarkib boshqaruvi.
class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  int _tab = 0;
  String _formation = '4-3-3';
  Player? _swapSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formation = _detectFormation(GameStateScope.of(context).squad);
  }

  String _detectFormation(List<Player> squad) {
    final lbs = squad.where((p) => p.isStarter && p.position == 'LB').length;
    final cms = squad.where((p) => p.isStarter && p.position == 'CM').length;
    if (lbs == 0) return '3-5-2';
    if (cms <= 2) return '4-4-2';
    return '4-3-3';
  }

  void _applyFormation(GameState state, String formation) {
    final spots = formations[formation]!;
    final starters = state.squad.where((p) => p.isStarter).toList();
    final used = <Player>{};

    Alignment spotFor(Player p) {
      final direct = spots[p.position];
      if (direct != null) return direct;
      // Qo'shnilik pozitsiyalar: CB <-> anything defense etc.
      for (final pos in _related(p.position)) {
        if (spots.containsKey(pos)) return spots[pos]!;
      }
      return p.alignment;
    }

    final taken = <Alignment>{};
    for (final p in starters) {
      var spot = spotFor(p);
      var guard = 0;
      while (taken.contains(spot) && guard < 8) {
        spot = Alignment(spot.x + 0.16, spot.y);
        guard++;
      }
      taken.add(spot);
      used.add(p);
      final i = state.squad.indexOf(p);
      state.squad[i] = p.copyWith(alignment: spot);
    }
    setState(() => _formation = formation);
    state.refresh();
  }

  List<String> _related(String pos) => switch (pos) {
        'CB' => ['CB'],
        'RB' || 'LB' => ['RB', 'LB'],
        'CM' || 'CDM' || 'CAM' => ['CM'],
        'LM' || 'RM' => ['LM', 'RM', 'CM'],
        'LW' => ['LW', 'LM'],
        'RW' => ['RW', 'RM'],
        'ST' => ['ST'],
        _ => const [],
      };

  void _autoLineup(GameState state) {
    final all = [...state.squad, ...state.reserves]
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final spots = formations[_formation]!;
    final spotKeys = <String>[];
    // GK birinchi.
    spotKeys.add('GK');
    spotKeys.addAll(spots.keys.where((k) => k != 'GK'));

    final newStarters = <Player>[];
    final rest = <Player>[];
    for (final p in all) {
      if (newStarters.length < 11) {
        newStarters.add(p);
      } else {
        rest.add(p);
      }
    }
    // GK ni eng yaxshi GK ga qo'yish.
    newStarters.sort((a, b) {
      final aGk = a.position == 'GK' ? 0 : 1;
      final bGk = b.position == 'GK' ? 0 : 1;
      return aGk != bGk ? aGk.compareTo(bGk) : 0;
    });

    final taken = <Alignment>{};
    final assigned = <Player>[];
    for (var i = 0; i < newStarters.length; i++) {
      final p = newStarters[i];
      final key = i < spotKeys.length ? spotKeys[i] : 'ST';
      var spot = spots[key]!;
      var guard = 0;
      while (taken.contains(spot) && guard < 8) {
        spot = Alignment(spot.x + 0.16, spot.y);
        guard++;
      }
      taken.add(spot);
      assigned.add(p.copyWith(position: key, alignment: spot));
    }
    state.squad
      ..clear()
      ..addAll(assigned);
    state.reserves
      ..clear()
      ..addAll(rest.map((p) => p.copyWith(alignment: Alignment.center)));
    state.refresh();
    setState(() => _swapSource = null);
  }

  void _onPlayerTap(GameState state, Player player, bool starter) {
    if (_swapSource == null) {
      setState(() => _swapSource = player);
      return;
    }
    final a = _swapSource!;
    if (a == player) {
      setState(() => _swapSource = null);
      return;
    }
    final aStarter = state.squad.contains(a);
    final bStarter = starter;
    if (aStarter && bStarter) {
      final i = state.squad.indexOf(a);
      final j = state.squad.indexOf(player);
      final tmp = state.squad[i].alignment;
      state.squad[i] = state.squad[i].copyWith(alignment: state.squad[j].alignment);
      state.squad[j] = state.squad[j].copyWith(alignment: tmp);
    } else if (aStarter != bStarter) {
      final starterP = aStarter ? a : player;
      final reserveP = aStarter ? player : a;
      final i = state.squad.indexOf(starterP);
      final j = state.reserves.indexOf(reserveP);
      final spot = state.squad[i].alignment;
      final pos = state.squad[i].position;
      state.squad[i] = reserveP.copyWith(alignment: spot, position: pos);
      state.reserves[j] = starterP.copyWith(alignment: Alignment.center);
    }
    state.refresh();
    setState(() => _swapSource = null);
  }

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    final wide = MediaQuery.of(context).size.width >= 760;
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => Column(
                children: [
                  _Header(tab: _tab, onTab: (i) => setState(() => _tab = i)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                      child: switch (_tab) {
                        0 => wide
                            ? Row(
                                children: [
                                  Expanded(child: _PitchView(state: state, swapSource: _swapSource, onPlayerTap: (p, s) => _onPlayerTap(state, p, s))),
                                  const SizedBox(width: 12),
                                  SizedBox(width: 280, child: _TeamPanel(state: state, formation: _formation, onAutoLineup: () => _autoLineup(state))),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 420, child: _PitchView(state: state, swapSource: _swapSource, onPlayerTap: (p, s) => _onPlayerTap(state, p, s))),
                                    const SizedBox(height: 12),
                                    SizedBox(height: 430, child: _TeamPanel(state: state, formation: _formation, onAutoLineup: () => _autoLineup(state))),
                                  ],
                                ),
                              ),
                        1 => _PlayersTab(
                              state: state,
                              swapSource: _swapSource,
                              onPlayerTap: (p, s) => _onPlayerTap(state, p, s),
                            ),
                        2 => _UpgradesTab(state: state),
                        _ => _TacticsTab(
                              formation: _formation,
                              onChanged: (f) => _applyFormation(state, f),
                            ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Sarlavha va tablar
// -----------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header({required this.tab, required this.onTab});

  final int tab;
  final ValueChanged<int> onTab;

  static const _tabs = ['My Team', 'Players', 'Upgrades', 'Tactics'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 12, 6),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  size: 17, color: AppColors.text),
            ),
          ),
          const SizedBox(width: 10),
          ...List.generate(_tabs.length, (i) {
            final active = i == tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: active ? AppColors.blue : Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: () => onTab(i),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: active
                            ? Colors.transparent
                            : Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: active ? Colors.white : AppColors.muted,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Maydon ko'rinishi
// -----------------------------------------------------------------------------

class _PitchView extends StatelessWidget {
  const _PitchView({
    required this.state,
    required this.swapSource,
    required this.onPlayerTap,
  });

  final GameState state;
  final Player? swapSource;
  final void Function(Player player, bool starter) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    final starters = state.squad;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 20),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(painter: _PitchPainter()),
            for (final p in starters)
              Align(
                alignment: p.alignment,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () => onPlayerTap(p, true),
                    child: PlayerCard(
                      player: p,
                      width: 74,
                      selected: swapSource == p,
                    ),
                  ),
                ),
              ),
            if (swapSource != null)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Swap: choose another player',
                      style: TextStyle(fontSize: 10.5, color: AppColors.lime),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PitchPainter extends CustomPainter {
  const _PitchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stripeCount = 8;
    for (var i = 0; i < stripeCount; i++) {
      final stripe = Rect.fromLTWH(
        rect.left,
        rect.top + rect.height / stripeCount * i,
        rect.width,
        rect.height / stripeCount + 1,
      );
      canvas.drawRect(
        stripe,
        Paint()..color = i.isEven ? AppColors.pitch : AppColors.pitchAlt,
      );
    }
    // Vignette.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.35)],
        ).createShader(rect),
    );

    final line = Paint()
      ..color = AppColors.pitchLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final w = size.width, h = size.height;
    // Chegaralar.
    canvas.drawRect(Rect.fromLTRB(w * 0.03, h * 0.03, w * 0.97, h * 0.97), line);
    // O'rta chiziq va doira.
    canvas.drawLine(Offset(w * 0.03, h / 2), Offset(w * 0.97, h / 2), line);
    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.11, line);
    // Jarima maydonlari.
    canvas.drawRect(Rect.fromLTRB(w * 0.22, h * 0.03, w * 0.78, h * 0.17), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.34, h * 0.03, w * 0.66, h * 0.09), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.22, h * 0.83, w * 0.78, h * 0.97), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.34, h * 0.91, w * 0.66, h * 0.97), line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// Jamoa paneli (o'ng)
// -----------------------------------------------------------------------------

class _TeamPanel extends StatelessWidget {
  const _TeamPanel({
    required this.state,
    required this.formation,
    required this.onAutoLineup,
  });

  final GameState state;
  final String formation;
  final VoidCallback onAutoLineup;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tight = constraints.maxHeight < 400;
          final content = <Widget>[
            const Text(
              'Team Power',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.muted),
            ),
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  state.teamPower,
                  style: const TextStyle(
                    fontSize: 38,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final s in MockData.teamStats)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _StatLine(label: s.label, value: s.value),
              ),
            if (!tight) const Spacer() else const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Formation',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.text),
                ),
                const Spacer(),
                Text(
                  formation,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.lime),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 74,
              child: CustomPaint(painter: _FormationPainter(formation)),
            ),
            const SizedBox(height: 12),
            Material(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onAutoLineup,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white),
                      SizedBox(width: 7),
                      Text(
                        'Auto Lineup',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
          final column = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: tight ? MainAxisSize.min : MainAxisSize.max,
            children: content,
          );
          return tight ? SingleChildScrollView(child: column) : column;
        },
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  const _StatLine({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74,
          child: Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: AppColors.text),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation(AppColors.lime),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 26,
          child: Text(
            '${(value * 100).round()}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: AppColors.text),
          ),
        ),
      ],
    );
  }
}

class _FormationPainter extends CustomPainter {
  const _FormationPainter(this.formation);

  final String formation;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(r, Paint()..color = AppColors.pitch);
    final line = Paint()
      ..color = AppColors.pitchLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(r, line);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), line);

    final spots = formations[formation]!;
    final taken = <Offset>{};
    final dot = Paint();
    for (final entry in spots.entries) {
      var o = Offset(
        size.width / 2 + entry.value.x * size.width * 0.42,
        size.height / 2 + entry.value.y * size.height * 0.42,
      );
      var guard = 0;
      while (taken.any((t) => (t - o).distance < 5) && guard < 6) {
        o = Offset(o.dx + 6, o.dy);
        guard++;
      }
      taken.add(o);
      dot.color = entry.key == 'GK' ? AppColors.gold : AppColors.blue;
      canvas.drawCircle(o, 4, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _FormationPainter oldDelegate) =>
      oldDelegate.formation != formation;
}

// -----------------------------------------------------------------------------
// Players tabi (almashtirish ro'yxati)
// -----------------------------------------------------------------------------

class _PlayersTab extends StatelessWidget {
  const _PlayersTab({
    required this.state,
    required this.swapSource,
    required this.onPlayerTap,
  });

  final GameState state;
  final Player? swapSource;
  final void Function(Player player, bool starter) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SectionTitle('Starting XI'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in state.squad)
              GestureDetector(
                onTap: () => onPlayerTap(p, true),
                child: PlayerCard(
                  player: p,
                  width: 86,
                  selected: swapSource == p,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        SectionTitle('Reserves (${state.reserves.length})'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in state.reserves)
              GestureDetector(
                onTap: () => onPlayerTap(p, false),
                child: PlayerCard(
                  player: p,
                  width: 86,
                  selected: swapSource == p,
                ),
              ),
            if (state.packPlayers.isNotEmpty) ...[
              for (final p in state.packPlayers)
                GestureDetector(
                  onTap: () => _promote(context, p),
                  child: PlayerCard(player: p, width: 86),
                ),
            ],
          ],
        ),
        if (state.packPlayers.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'Tap a new player to move him into reserves',
            style: TextStyle(fontSize: 10.5, color: AppColors.muted),
          ),
        ],
      ],
    );
  }

  void _promote(BuildContext context, Player p) {
    final state = GameStateScope.of(context);
    state.packPlayers.remove(p);
    state.reserves.add(p);
    state.refresh();
  }
}

// -----------------------------------------------------------------------------
// Upgrades tabi
// -----------------------------------------------------------------------------

class _UpgradesTab extends StatelessWidget {
  const _UpgradesTab({required this.state});

  final GameState state;

  int _cost(Player p) => (p.rating - 84) * 40000;

  @override
  Widget build(BuildContext context) {
    final all = [...state.squad, ...state.reserves, ...state.packPlayers];
    return ListView.separated(
      itemCount: all.length,
      separatorBuilder: (context, i) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = all[i];
        final cost = _cost(p);
        final maxed = p.rating >= 99;
        return GlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          radius: 12,
          child: Row(
            children: [
              PlayerCard(player: p, width: 46, showName: false),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      '${p.position} · OVR ${p.rating}',
                      style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              if (maxed)
                const Text(
                  'MAX',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.gold,
                  ),
                )
              else
                Material(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      if (state.spendCoins(cost)) {
                        _upgrade(p);
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_upward_rounded,
                              size: 13, color: Color(0xFF241A02)),
                          const SizedBox(width: 4),
                          Text(
                            '+1  ${_formatCost(cost)}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF241A02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _upgrade(Player p) {
    final i = state.squad.indexOf(p);
    if (i >= 0) {
      state.squad[i] = p.copyWith(
        rating: p.rating + 1,
        pace: p.pace + 1,
        shooting: p.shooting + 1,
        passing: p.passing + 1,
        defending: p.defending + 1,
      );
    } else {
      final j = state.reserves.indexOf(p);
      if (j >= 0) {
        state.reserves[j] = p.copyWith(
          rating: p.rating + 1,
          pace: p.pace + 1,
          shooting: p.shooting + 1,
          passing: p.passing + 1,
          defending: p.defending + 1,
        );
      } else {
        final k = state.packPlayers.indexOf(p);
        if (k >= 0) {
          state.packPlayers[k] = p.copyWith(
            rating: p.rating + 1,
            pace: p.pace + 1,
            shooting: p.shooting + 1,
            passing: p.passing + 1,
            defending: p.defending + 1,
          );
        }
      }
    }
    state.refresh();
  }

  static String _formatCost(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).round()}K';
    return '$v';
  }
}

// -----------------------------------------------------------------------------
// Tactics tabi
// -----------------------------------------------------------------------------

class _TacticsTab extends StatelessWidget {
  const _TacticsTab({required this.formation, required this.onChanged});

  final String formation;
  final ValueChanged<String> onChanged;

  static const _styles = [
    (name: 'Balanced', icon: Icons.balance_rounded),
    (name: 'Attacking', icon: Icons.local_fire_department_rounded),
    (name: 'Defensive', icon: Icons.shield_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SectionTitle('Formation'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (final f in formations.keys)
              GestureDetector(
                onTap: () => onChanged(f),
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: f == formation
                        ? AppColors.blue.withValues(alpha: 0.25)
                        : Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: f == formation
                          ? AppColors.blue
                          : Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 84,
                        child: CustomPaint(painter: _FormationPainter(f)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        f,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: f == formation ? Colors.white : AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        const SectionTitle('Team Style'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (final s in _styles)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(s.icon, size: 15, color: AppColors.lime),
                    const SizedBox(width: 6),
                    Text(
                      s.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

```

## `lib/screens/tournaments_screen.dart`

```dart
import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'match_screen.dart';

/// Turnirlar ekrani — UCL finaliga yo'l.
class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  Duration _countdown = const Duration(days: 6, hours: 12, minutes: 37);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _countdown -= const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _countdownLabel {
    final d = _countdown.inDays;
    final h = _countdown.inHours % 24;
    final m = _countdown.inMinutes % 60;
    final s = _countdown.inSeconds % 60;
    return '${d}d ${h.toString().padLeft(2, '0')}h ${m.toString().padLeft(2, '0')}m ${s.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    final match = MockData.nextMatch;
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/champions_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const _Header(title: 'Tournaments'),
                  const SizedBox(height: 14),
                  GlassPanel(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        const Icon(Icons.shield_rounded,
                            size: 34, color: AppColors.blue),
                        const SizedBox(height: 6),
                        const Text(
                          'UCL EVENT',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: AppColors.text,
                          ),
                        ),
                        const Text(
                          'CHAMPIONS LEAGUE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.5,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ClubSide(club: match.home),
                            const Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: AppColors.muted,
                              ),
                            ),
                            _ClubSide(club: match.away),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'THE FINAL · ${match.dateLabel} · ${match.timeLabel}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.timer_rounded,
                                size: 14, color: AppColors.gold),
                            const SizedBox(width: 6),
                            Text(
                              _countdownLabel,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Material(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () => pushScreen(
                              context,
                              const MatchScreen(match: MockData.nextMatch),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Text(
                                'PLAY FINAL NOW',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF241A02),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassPanel(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle('Road to the final'),
                        const SizedBox(height: 10),
                        _Round(label: 'Quarter-final', score: '3 - 1', done: true),
                        _Round(label: 'Semi-final', score: '2 - 0', done: true),
                        _Round(
                          label: 'FINAL',
                          score: state.uclChampion ? 'WON' : 'vs ${match.away.short}',
                          done: state.uclChampion,
                          highlight: !state.uclChampion,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClubSide extends StatelessWidget {
  const _ClubSide({required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClubCrest(club: club, size: 56),
        const SizedBox(height: 6),
        Text(
          club.name,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _Round extends StatelessWidget {
  const _Round({
    required this.label,
    required this.score,
    required this.done,
    this.highlight = false,
  });

  final String label;
  final String score;
  final bool done;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.gold.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight
              ? AppColors.gold.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 16,
            color: done ? AppColors.lime : AppColors.muted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: highlight ? FontWeight.w900 : FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              color: done ? AppColors.lime : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: const Icon(Icons.arrow_back_rounded,
                size: 17, color: AppColors.text),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

```

## `lib/screens/training_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'game_screen.dart';

/// Mashg'ulot ekrani — penalti rejimiga kirish.
class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.5),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GlassPanel(
                  padding: const EdgeInsets.all(22),
                  child: SizedBox(
                    width: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.45),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.12)),
                                ),
                                child: const Icon(Icons.arrow_back_rounded,
                                    size: 17, color: AppColors.text),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Training',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Icon(Icons.sports_rounded,
                            size: 44, color: AppColors.lime),
                        const SizedBox(height: 8),
                        const Text(
                          'Penalty Practice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Sharpen your finishing in the 3D arena. 10 shots, '
                          'the keeper reads you better every time — aim for the corners!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: AppColors.muted),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Reward: up to 50,000 coins per session',
                          style: TextStyle(fontSize: 11.5, color: AppColors.gold),
                        ),
                        const SizedBox(height: 16),
                        Material(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(999),
                          child: InkWell(
                            onTap: () => pushScreen(context, const GameScreen()),
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text(
                                'START TRAINING',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF241A02),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## `lib/screens/transfers_screen.dart`

```dart
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Transfer bozori — sotib olish va sotish.
class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  static String _formatPrice(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).round()}K';
    return '$v';
  }

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.62),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 12, 6),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12)),
                            ),
                            child: const Icon(Icons.arrow_back_rounded,
                                size: 17, color: AppColors.text),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Transfers',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const Spacer(),
                        const CurrencyBar(compact: true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ListView(
                            padding: const EdgeInsets.all(12),
                            children: [
                              const SectionTitle('Transfer Market'),
                              const SizedBox(height: 8),
                              for (final t in state.market)
                                _MarketRow(
                                  target: t,
                                  canAfford: state.coins >= t.price,
                                  onBuy: () {
                                    if (state.buyPlayer(t)) {
                                      _toast(context, '${t.player.name} signed!');
                                    } else {
                                      _toast(context, 'Not enough coins!');
                                    }
                                  },
                                ),
                              if (state.market.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: Text(
                                      'Market is empty — all stars signed!',
                                      style: TextStyle(color: AppColors.muted),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListView(
                            padding: const EdgeInsets.all(12),
                            children: [
                              const SectionTitle('Sell from reserves'),
                              const SizedBox(height: 8),
                              for (final p in state.reserves)
                                _SellRow(
                                  player: p,
                                  price: p.rating * 900000,
                                  onSell: () {
                                    state.sellPlayer(p);
                                    _toast(context,
                                        '${p.name} sold for ${_formatPrice(p.rating * 900000)}');
                                  },
                                ),
                              if (state.reserves.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: Text(
                                      'No reserves to sell',
                                      style: TextStyle(color: AppColors.muted),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _MarketRow extends StatelessWidget {
  const _MarketRow({
    required this.target,
    required this.canAfford,
    required this.onBuy,
  });

  final TransferTarget target;
  final bool canAfford;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426).withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          PlayerCard(player: target.player, width: 42, showName: false),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  target.player.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  '${target.player.position} · OVR ${target.player.rating} · ${target.sellingClub}',
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(target.price / 1000000).toStringAsFixed(1)}M',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 4),
              Material(
                color: canAfford ? AppColors.lime : Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: canAfford ? onBuy : null,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    child: Text(
                      'SIGN',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        color: canAfford
                            ? const Color(0xFF241A02)
                            : AppColors.muted,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SellRow extends StatelessWidget {
  const _SellRow({
    required this.player,
    required this.price,
    required this.onSell,
  });

  final Player player;
  final int price;
  final VoidCallback onSell;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426).withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          PlayerCard(player: player, width: 40, showName: false),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  '${player.position} · OVR ${player.rating}',
                  style: const TextStyle(fontSize: 10, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.red.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: onSell,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'SELL ${(price / 1000000).toStringAsFixed(1)}M',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## `lib/state/game_state.dart`

```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';

/// O'yinning umumiy holati: profil, valyuta, tarkib, jadval, yutuqlar.
class GameState extends ChangeNotifier {
  GameState({math.Random? rng}) : _rng = rng ?? math.Random() {
    _syncMillionaire();
  }

  final math.Random _rng;

  // ---- Profil ----
  String userName = MockData.userName;
  String userHandle = MockData.userHandle;
  int level = MockData.level;
  int xp = MockData.xp;
  int xpMax = MockData.xpMax;
  int coins = MockData.coins;
  int gems = MockData.gems;
  int notifications = 3;

  Club get userClub => MockData.userClub;

  // ---- Tarkib ----
  final List<Player> squad = List.of(MockData.squad);
  final List<Player> reserves = List.of(MockData.reserves);
  final List<Player> packPlayers = [];

  // ---- Jadval ----
  final List<Standing> table = List.of(MockData.standings);

  // ---- Karyera ----
  int careerMatches = MockData.careerMatches;
  int careerGoals = MockData.careerGoals;
  int careerAssists = MockData.careerAssists;
  int careerWins = MockData.careerWins;
  int trophies = 2;
  bool uclChampion = false;

  // ---- Yutuqlar ----
  final List<Achievement> achievements = List.of(MockData.achievements);

  // ---- Transfer ----
  final List<TransferTarget> market = List.of(MockData.transferMarket);

  String get teamPower {
    if (squad.isEmpty) return '0.0';
    final avg = squad.map((p) => p.rating).reduce((a, b) => a + b) / squad.length;
    return avg.toStringAsFixed(1);
  }

  /// Tashqi ekranlardan o'zgarishlarni e'lon qilish uchun.
  void refresh() => notifyListeners();

  // ---------------------------------------------------------------------------
  // Valyuta va XP
  // ---------------------------------------------------------------------------

  void addCoins(int amount) {
    coins += amount;
    _syncMillionaire();
    notifyListeners();
  }

  bool spendCoins(int amount) {
    if (coins < amount) return false;
    coins -= amount;
    notifyListeners();
    return true;
  }

  bool spendGems(int amount) {
    if (gems < amount) return false;
    gems -= amount;
    notifyListeners();
    return true;
  }

  void addGems(int amount) {
    gems += amount;
    notifyListeners();
  }

  void addXp(int amount) {
    xp += amount;
    while (xp >= xpMax) {
      xp -= xpMax;
      level++;
      xpMax = (xpMax * 1.25).round();
      notifications++;
    }
    notifyListeners();
  }

  void clearNotifications() {
    notifications = 0;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Match natijalari
  // ---------------------------------------------------------------------------

  /// O'yin o'ynalganini yozadi: jadval, karyera, valyuta, yutuqlarni yangilaydi.
  /// So'vqqalarni qaytaradi: `(coins, xp)`.
  ({int coins, int xp}) recordMatchResult({
    required bool won,
    required bool draw,
    required int goalsFor,
    required int goalsAgainst,
    bool isFinal = false,
  }) {
    careerMatches++;
    careerGoals += goalsFor;
    if (won) careerWins++;
    _bumpProgress('playmaker', 1);

    // Jadvalni yangilash.
    for (var i = 0; i < table.length; i++) {
      final s = table[i];
      if (!s.isUser) continue;
      table[i] = s.copyWith(
        played: s.played + 1,
        won: s.won + (won ? 1 : 0),
        drawn: s.drawn + (draw ? 1 : 0),
        lost: s.lost + (!won && !draw ? 1 : 0),
        goalsFor: s.goalsFor + goalsFor,
        goalsAgainst: s.goalsAgainst + goalsAgainst,
      );
    }
    // Qolgan klublar ham o'ynaydi.
    for (var i = 0; i < table.length; i++) {
      if (table[i].isUser) continue;
      final s = table[i];
      final homeWin = _rng.nextDouble();
      table[i] = s.copyWith(
        played: s.played + 1,
        won: s.won + (homeWin > 0.55 ? 1 : 0),
        drawn: s.drawn + (homeWin > 0.35 && homeWin <= 0.55 ? 1 : 0),
        lost: s.lost + (homeWin <= 0.35 ? 1 : 0),
      );
    }
    table.sort((a, b) => b.points.compareTo(a.points));

    final rewardCoins = won ? 150000 : (draw ? 60000 : 25000);
    final rewardXp = won ? 400 : (draw ? 200 : 100);
    addCoins(rewardCoins);
    addXp(rewardXp);

    if (won) {
      _bumpProgress('first_win', 1);
      _bumpProgress('striker', goalsFor);
    }

    if (isFinal && won) {
      uclChampion = true;
      trophies++;
      _bumpProgress('champion', 1);
      addCoins(500000);
      addGems(250);
    }

    notifyListeners();
    return (coins: rewardCoins, xp: rewardXp);
  }

  // ---------------------------------------------------------------------------
  // Yutuqlar
  // ---------------------------------------------------------------------------

  bool claimAchievement(String id) {
    final i = achievements.indexWhere((a) => a.id == id);
    if (i < 0) return false;
    final a = achievements[i];
    if (!a.isComplete || a.claimed) return false;
    achievements[i] = a.copyWith(claimed: true);
    addCoins(a.rewardCoins);
    return true;
  }

  void _bumpProgress(String id, int delta) {
    final i = achievements.indexWhere((a) => a.id == id);
    if (i < 0) return;
    final a = achievements[i];
    achievements[i] = a.copyWith(progress: a.progress + delta);
  }

  void _syncMillionaire() {
    final i = achievements.indexWhere((a) => a.id == 'rich');
    if (i >= 0 && coins >= 3000000) {
      achievements[i] = achievements[i].copyWith(progress: 1);
    }
  }

  // ---------------------------------------------------------------------------
  // Pack ochish
  // ---------------------------------------------------------------------------

  /// Tasodifiy o'yinchini tarkibga qo'shadi.
  Player openPack() {
    final pool = MockData.packPool;
    final p = pool[_rng.nextInt(pool.length)];
    packPlayers.add(p);
    notifyListeners();
    return p;
  }

  // ---------------------------------------------------------------------------
  // Transferlar
  // ---------------------------------------------------------------------------

  bool buyPlayer(TransferTarget target) {
    if (!spendCoins(target.price)) return false;
    market.remove(target);
    reserves.add(target.player);
    notifyListeners();
    return true;
  }

  void sellPlayer(Player player) {
    final price = (player.rating * 900000).round();
    reserves.remove(player);
    final i = squad.indexOf(player);
    if (i >= 0) squad.removeAt(i);
    addCoins(price);
    notifyListeners();
  }
}

/// GameState ni widget daraxtida yetkazib beruvchi scope.
class GameStateScope extends InheritedNotifier<GameState> {
  const GameStateScope({super.key, required GameState state, required super.child})
      : super(notifier: state);

  static GameState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<GameStateScope>();
    assert(scope != null, 'GameStateScope topilmadi');
    return scope!.notifier!;
  }
}

```

## `lib/theme/app_colors.dart`

```dart
import 'package:flutter/material.dart';

/// Fodball rang palitrasi.
abstract final class AppColors {
  static const bg = Color(0xFF050A16);
  static const bgDeep = Color(0xFF02050C);
  static const surface = Color(0xFF0B1426);
  static const surfaceAlt = Color(0xFF111E38);
  static const stroke = Color(0xFF1C2A47);
  static const strokeSoft = Color(0xFF16223C);

  static const lime = Color(0xFFC8FF4D);
  static const limeDark = Color(0xFF9BDD2B);
  static const gold = Color(0xFFFFC542);
  static const red = Color(0xFFFF4D5E);
  static const blue = Color(0xFF4D7CFF);
  static const violet = Color(0xFF8B5CF6);

  static const text = Color(0xFFF5F8FF);
  static const muted = Color(0xFF8794B4);
  static const mutedDark = Color(0xFF5C6883);

  static const pitch = Color(0xFF0F3B24);
  static const pitchAlt = Color(0xFF14502F);
  static const pitchLine = Color(0x66FFFFFF);
}

```

## `lib/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.lime,
        onPrimary: AppColors.bgDeep,
        secondary: AppColors.gold,
        onSecondary: AppColors.bgDeep,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        error: AppColors.red,
      ),
      textTheme: base.textTheme
          .apply(
            bodyColor: AppColors.text,
            displayColor: AppColors.text,
          )
          .copyWith(
            displayLarge: const TextStyle(
              fontSize: 44,
              height: 0.95,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              color: AppColors.text,
            ),
            headlineMedium: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: AppColors.text,
            ),
            titleMedium: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
            bodyMedium: const TextStyle(
              fontSize: 13,
              height: 1.35,
              color: AppColors.text,
            ),
            bodySmall: const TextStyle(
              fontSize: 11.5,
              height: 1.3,
              color: AppColors.muted,
            ),
            labelSmall: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: AppColors.muted,
            ),
          ),
      dividerColor: AppColors.stroke,
      splashColor: AppColors.lime.withValues(alpha: 0.06),
      highlightColor: Colors.transparent,
    );
  }
}

```

## `lib/widgets/ui.dart`

```dart
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';

/// Klub gerbi — stilizatsiya halqali badge.
class ClubCrest extends StatelessWidget {
  const ClubCrest({super.key, required this.club, this.size = 34});

  final Club club;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            club.crestColors[0],
            club.crestColors[1],
            club.crestColors[0],
            club.crestColors[1],
            club.crestColors[0],
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.75), width: 1.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size * 0.62,
          height: size * 0.62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0B1426),
            border: Border.all(
              color: club.crestColors[0].withValues(alpha: 0.9),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              club.short,
              style: TextStyle(
                fontSize: size * 0.22,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Valyuta pillasi: coins yoki gems.
class CurrencyPill extends StatelessWidget {
  const CurrencyPill({
    super.key,
    required this.icon,
    required this.value,
    required this.color,
    this.onAdd,
  });

  final IconData icon;
  final String value;
  final Color color;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 110),
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: AppColors.text,
                ),
              ),
            ),
            if (onAdd != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 12, color: Color(0xFF0A0F1E)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Yuqori paneldagi valyutalar bloki (GameState dan o'qiydi).
class CurrencyBar extends StatelessWidget {
  const CurrencyBar({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CurrencyPill(
              icon: Icons.monetization_on_rounded,
              value: _format(state.coins),
              color: AppColors.gold,
              onAdd: () => Navigator.of(context).pushNamed('/store'),
            ),
          ),
          if (!compact) const SizedBox(width: 8),
          if (!compact)
            Flexible(
              child: CurrencyPill(
                icon: Icons.diamond_rounded,
                value: _format(state.gems),
                color: AppColors.violet,
                onAdd: () => Navigator.of(context).pushNamed('/store'),
              ),
            ),
        ],
      ),
    );
  }

  static String _format(int v) {
    if (v >= 1000000) {
      final m = v / 1000000;
      return '${m == m.roundToDouble() ? m.toStringAsFixed(0) : m.toStringAsFixed(1)}M';
    }
    if (v >= 1000) {
      final k = v / 1000;
      return '${k == k.roundToDouble() ? k.toStringAsFixed(0) : k.toStringAsFixed(1)}K';
    }
    return '$v';
  }
}

/// Shaffof qorako'k panel.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 18,
    this.alpha = 0.62,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF16233F).withValues(alpha: alpha),
            const Color(0xFF0A1120).withValues(alpha: alpha),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Bo'lim sarlavhasi.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.2,
              color: AppColors.text,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// Bayroq halqasi — 2 rangli doira.
class FlagDot extends StatelessWidget {
  const FlagDot({super.key, required this.colors, this.size = 10});

  final List<Color> colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [colors[0], colors[1], colors[0]],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
      ),
    );
  }
}

/// O'yinchi kartasi (eFootball uslubida): rating, pozitsiya, portret, ism, bayroq.
class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.player,
    this.width = 78,
    this.showName = true,
    this.selected = false,
  });

  final Player player;
  final double width;
  final bool showName;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final h = width * 1.42;
    final ratingColor = player.rating >= 95
        ? AppColors.gold
        : player.rating >= 90
            ? AppColors.violet
            : AppColors.blue;
    return Container(
      width: width,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            player.color.withValues(alpha: 0.85),
            const Color(0xFF0A1120),
          ],
        ),
        border: Border.all(
          color: selected
              ? AppColors.lime
              : Colors.white.withValues(alpha: 0.14),
          width: selected ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: player.color.withValues(alpha: 0.25),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 6,
            top: 4,
            child: Text(
              '${player.rating}',
              style: TextStyle(
                fontSize: width * 0.19,
                height: 1,
                fontWeight: FontWeight.w900,
                color: ratingColor,
              ),
            ),
          ),
          Positioned(
            right: 6,
            top: 5,
            child: Text(
              player.position,
              style: TextStyle(
                fontSize: width * 0.11,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
          Center(
            child: Container(
              width: width * 0.42,
              height: width * 0.42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
              child: Center(
                child: Text(
                  player.initials,
                  style: TextStyle(
                    fontSize: width * 0.15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (showName)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(9),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        player.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.105,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    FlagDot(colors: player.flag, size: width * 0.1),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Yuklab olish tugmachasi.
void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}

```

## `test/game_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/game3d/penalty_game.dart';
import 'package:fodball/game3d/vec3.dart';
import 'package:fodball/screens/game_screen.dart';

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

        await tester.pumpWidget(const MaterialApp(home: GameScreen()));
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

```

## `test/match_test.dart`

```dart
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

```

## `test/screenshot_test.dart`

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/data/mock_data.dart';
import 'package:fodball/screens/home_screen.dart';
import 'package:fodball/screens/match_screen.dart';
import 'package:fodball/screens/store_screen.dart';
import 'package:fodball/screens/team_screen.dart';
import 'package:fodball/state/game_state.dart';
import 'package:fodball/theme/app_theme.dart';

Future<void> _loadRealFonts() async {
  final sdk = Platform.environment['FLUTTER_ROOT'] ??
      r'C:\Users\user\Downloads\flutter_windows_3.47.5-stable\flutter';
  final iconFont = File(
      '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
  if (iconFont.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(iconFont.readAsBytesSync())));
    await loader.load();
  }
  final roboto = File(r'C:\Windows\Fonts\segoeui.ttf');
  if (roboto.existsSync()) {
    final loader = FontLoader('Roboto')
      ..addFont(Future.value(ByteData.sublistView(roboto.readAsBytesSync())));
    final bold = File(r'C:\Windows\Fonts\segoeuib.ttf');
    if (bold.existsSync()) {
      loader.addFont(
          Future.value(ByteData.sublistView(bold.readAsBytesSync())));
    }
    await loader.load();
  }
}

Future<void> _pump(WidgetTester tester, Size size, Widget screen,
    {bool settle = true}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final theme = AppTheme.dark;
  await tester.pumpWidget(
    RepaintBoundary(
      key: const ValueKey('shot'),
      child: GameStateScope(
        state: GameState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
            textTheme: theme.textTheme.apply(fontFamily: 'Roboto'),
          ),
          home: screen,
        ),
      ),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    for (var i = 0; i < 180; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
  }
}

void main() {
  setUpAll(_loadRealFonts);

  testWidgets('shot: home portrait', (tester) async {
    await _pump(tester, const Size(360, 806), const HomeScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_home_portrait.png'));
  });

  testWidgets('shot: home landscape', (tester) async {
    await _pump(tester, const Size(806, 360), const HomeScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_home_landscape.png'));
  });

  testWidgets('shot: team', (tester) async {
    await _pump(tester, const Size(806, 360), const TeamScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_team.png'));
  });

  testWidgets('shot: match', (tester) async {
    await _pump(tester, const Size(806, 360),
        const MatchScreen(match: MockData.nextMatch),
        settle: false);
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_match.png'));
  });

  testWidgets('shot: store', (tester) async {
    await _pump(tester, const Size(360, 806), const StoreScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_store.png'));
  });
}

```

## `test/widget_test.dart`

```dart
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

```

## `pubspec.yaml`

```yaml
name: fodball
description: "Fodball - football club dashboard built with Flutter."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.13.4

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  assets:
    - assets/images/

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
```
