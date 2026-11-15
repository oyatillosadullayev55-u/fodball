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
