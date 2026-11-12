import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import 'common.dart';

/// Yuqori panel: profil, valyutalar va bo'limlar.
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final showTabs = width >= 760;
        final showName = width >= 480;
        final showGems = width >= 620;

        return GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          radius: 20,
          child: Row(
            children: [
              const GradientAvatar(
                label: 'OA',
                color: AppColors.lime,
                size: 42,
              ),
              const SizedBox(width: 11),
              if (showName)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        MockData.userName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Pill(
                            text: 'LEVEL ${MockData.level}',
                            color: Color(0x22C8FF4D),
                            textColor: AppColors.lime,
                            padding: EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Pro League',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                color: AppColors.muted.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                const Spacer(),
              if (showGems) ...[
                const CoinChip(
                  amount: MockData.gems,
                  icon: Icons.diamond_rounded,
                  color: AppColors.blue,
                ),
                const SizedBox(width: 8),
              ],
              const CoinChip(amount: MockData.coins),
              if (showTabs) ...[
                const SizedBox(width: 14),
                const _SectionTabs(),
                const SizedBox(width: 10),
                const CircleIconButton(
                  icon: Icons.notifications_none_rounded,
                  tooltip: 'Notifications',
                ),
              ] else ...[
                const SizedBox(width: 8),
                const CircleIconButton(icon: Icons.menu_rounded),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SectionTabs extends StatelessWidget {
  const _SectionTabs();

  @override
  Widget build(BuildContext context) {
    const tabs = ['Players', 'Upgrades', 'Tactics'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgDeep,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.strokeSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < tabs.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: i == 0 ? AppColors.lime : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: i == 0 ? AppColors.bgDeep : AppColors.muted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
