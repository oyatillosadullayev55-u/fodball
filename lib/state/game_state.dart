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
