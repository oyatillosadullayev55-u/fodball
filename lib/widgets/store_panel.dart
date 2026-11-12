import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import 'common.dart';

/// O'ng ustun pastki qismi: do'kon va maxsus taklif.
class StorePanel extends StatelessWidget {
  const StorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _StoreCard(),
        SizedBox(height: 14),
        _SpecialOfferCard(),
      ],
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'Store',
            trailing: CoinChip(amount: MockData.coins, onAdd: null),
          ),
          const SizedBox(height: 14),
          const _StoreTabs(),
          const SizedBox(height: 14),
          for (var i = 0; i < MockData.packs.length; i++) ...[
            _PackTile(pack: MockData.packs[i]),
            if (i != MockData.packs.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _StoreTabs extends StatelessWidget {
  const _StoreTabs();

  @override
  Widget build(BuildContext context) {
    const tabs = ['Packs', 'Players', 'Coins'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgDeep.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.strokeSoft),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: i == 0 ? AppColors.surfaceAlt : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                  border: i == 0
                      ? Border.all(color: AppColors.stroke)
                      : null,
                ),
                child: Text(
                  tabs[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: i == 0 ? AppColors.text : AppColors.muted,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PackTile extends StatelessWidget {
  const _PackTile({required this.pack});

  final Pack pack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  pack.accent.withValues(alpha: 0.30),
                  pack.accent.withValues(alpha: 0.06),
                ],
              ),
              border: Border.all(color: pack.accent.withValues(alpha: 0.35)),
            ),
            child: Icon(pack.icon, size: 20, color: pack.accent),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        pack.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    if (pack.badge != null) ...[
                      const SizedBox(width: 6),
                      Pill(
                        text: pack.badge!,
                        color: pack.accent.withValues(alpha: 0.16),
                        textColor: pack.accent,
                        fontSize: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_rounded,
                      size: 12,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      pack.price,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted,
                      ),
                    ),
                    if (pack.tag != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        pack.tag!,
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: pack.accent.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.lime,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.shopping_bag_rounded,
              size: 15,
              color: AppColors.bgDeep,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialOfferCard extends StatelessWidget {
  const _SpecialOfferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A2A05), Color(0xFF1A1408), Color(0xFF0B1220)],
        ),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.28)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -30,
            child: Icon(
              Icons.local_fire_department_rounded,
              size: 120,
              color: AppColors.gold.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Pill(
                    text: 'SPECIAL OFFER',
                    color: Color(0x26FFC542),
                    textColor: AppColors.gold,
                    icon: Icons.local_fire_department_rounded,
                  ),
                  Spacer(),
                  Pill(
                    text: '-70%',
                    color: AppColors.gold,
                    textColor: AppColors.bgDeep,
                    fontSize: 10.5,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        const Text(
                          '\$4.99',
                          style: TextStyle(
                            fontSize: 30,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.8,
                            color: AppColors.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '\$16.63',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.muted.withValues(alpha: 0.8),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const PrimaryButton(
                    label: 'Claim',
                    icon: Icons.bolt_rounded,
                    color: AppColors.gold,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Legendary Pack + 2,500 coins + rare kit',
                style: TextStyle(fontSize: 11, color: AppColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
