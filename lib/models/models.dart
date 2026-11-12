import 'package:flutter/material.dart';

/// Maydondagi o'yinchi.
@immutable
class Player {
  const Player({
    required this.name,
    required this.position,
    required this.rating,
    required this.alignment,
    required this.color,
  });

  final String name;
  final String position;
  final int rating;

  /// Maydon ichidagi nisbiy joylashuv (-1..1).
  final Alignment alignment;
  final Color color;

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

/// Chap paneldagi navigatsiya elementi.
@immutable
class MenuEntry {
  const MenuEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.highlighted = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool highlighted;
}

/// Do'kondagi paket.
@immutable
class Pack {
  const Pack({
    required this.name,
    required this.price,
    required this.accent,
    required this.icon,
    this.tag,
    this.badge,
  });

  final String name;
  final String price;
  final Color accent;
  final IconData icon;
  final String? tag;
  final String? badge;
}
