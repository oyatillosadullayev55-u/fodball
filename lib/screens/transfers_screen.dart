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
