import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';

abstract final class MockData {
  static const userName = 'Oyatillo_4349';
  static const level = 28;
  static const coins = '8,750';
  static const gems = '120';
  static const teamPower = '96.8';
  static const formation = '4-3-3';
  static const club = 'Real Madrid';

  static const players = <Player>[
    Player(
      name: 'Alisson',
      position: 'GK',
      rating: 96,
      alignment: Alignment(0, 0.94),
      color: Color(0xFFF5B301),
    ),
    Player(
      name: 'Hernández',
      position: 'LB',
      rating: 93,
      alignment: Alignment(-0.78, 0.6),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'van Dijk',
      position: 'CB',
      rating: 94,
      alignment: Alignment(-0.26, 0.68),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'Rüdiger',
      position: 'CB',
      rating: 95,
      alignment: Alignment(0.26, 0.68),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'Hakimi',
      position: 'RB',
      rating: 93,
      alignment: Alignment(0.78, 0.6),
      color: Color(0xFF2F6BFF),
    ),
    Player(
      name: 'Pedri',
      position: 'CM',
      rating: 95,
      alignment: Alignment(-0.55, 0.16),
      color: Color(0xFF2F6BFF),
    ),
    Player(
      name: 'Bellingham',
      position: 'CM',
      rating: 95,
      alignment: Alignment(0, 0.26),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'De Bruyne',
      position: 'CM',
      rating: 96,
      alignment: Alignment(0.55, 0.16),
      color: Color(0xFF6CABDD),
    ),
    Player(
      name: 'Vinicius Jr.',
      position: 'LW',
      rating: 97,
      alignment: Alignment(-0.78, -0.62),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'Mbappé',
      position: 'ST',
      rating: 97,
      alignment: Alignment(0, -0.8),
      color: Color(0xFFE23E57),
    ),
    Player(
      name: 'Salah',
      position: 'RW',
      rating: 98,
      alignment: Alignment(0.78, -0.62),
      color: Color(0xFFC8102E),
    ),
  ];

  static const menu = <MenuEntry>[
    MenuEntry(
      title: 'PLAY',
      subtitle: 'Start a Match',
      icon: Icons.sports_soccer_rounded,
      highlighted: true,
    ),
    MenuEntry(
      title: 'TOURNAMENT',
      subtitle: 'Win Trophies',
      icon: Icons.emoji_events_rounded,
    ),
    MenuEntry(
      title: 'MY CLUB',
      subtitle: 'Build Your Team',
      icon: Icons.shield_rounded,
    ),
    MenuEntry(
      title: 'STORE',
      subtitle: 'Get Rewards',
      icon: Icons.storefront_rounded,
    ),
  ];

  static const packs = <Pack>[
    Pack(
      name: 'Standard Pack',
      price: '100,000',
      accent: AppColors.blue,
      icon: Icons.inventory_2_rounded,
      tag: 'BRONZE',
    ),
    Pack(
      name: 'Premium Pack',
      price: '500',
      accent: AppColors.violet,
      icon: Icons.workspace_premium_rounded,
      tag: 'GOLD',
      badge: 'POPULAR',
    ),
    Pack(
      name: 'Legendary Pack',
      price: '1,000',
      accent: AppColors.gold,
      icon: Icons.auto_awesome_rounded,
      tag: 'ICON',
    ),
  ];

  static const stats = <({String label, double value, Color color})>[
    (label: 'Attack', value: 0.96, color: AppColors.red),
    (label: 'Midfield', value: 0.95, color: AppColors.lime),
    (label: 'Goalkeeper', value: 0.96, color: AppColors.blue),
  ];
}
