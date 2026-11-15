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
