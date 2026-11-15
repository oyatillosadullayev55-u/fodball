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
