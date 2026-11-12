import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/common.dart';
import '../widgets/hero_card.dart';
import '../widgets/match_control_card.dart';
import '../widgets/side_panel.dart';
import '../widgets/store_panel.dart';
import '../widgets/team_panel.dart';
import '../widgets/top_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                children: [
                  TopBar(
                    onBack: Navigator.of(context).canPop()
                        ? () => Navigator.of(context).pop()
                        : null,
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        if (width >= 1180) return const _WideLayout();
                        if (width >= 860) return const _MediumLayout();
                        return const _NarrowLayout();
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

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF071022), AppColors.bg, AppColors.bgDeep],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -160,
            left: -120,
            child: _Glow(
              size: 420,
              color: AppColors.lime.withValues(alpha: 0.10),
            ),
          ),
          Positioned(
            top: 120,
            right: -180,
            child: _Glow(
              size: 520,
              color: AppColors.blue.withValues(alpha: 0.10),
            ),
          ),
          Positioned(
            bottom: -220,
            left: 240,
            child: _Glow(
              size: 520,
              color: AppColors.violet.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(width: 300, child: SidePanel()),
          SizedBox(width: 16),
          Expanded(child: _CenterColumn()),
          SizedBox(width: 16),
          SizedBox(width: 440, child: _RightColumn()),
        ],
      ),
    );
  }
}

class _MediumLayout extends StatelessWidget {
  const _MediumLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(width: 282, child: SidePanel()),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                _CenterColumn(),
                SizedBox(height: 16),
                _RightColumn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        children: const [
          _CenterColumn(),
          SizedBox(height: 16),
          _RightColumn(),
          SizedBox(height: 16),
          SidePanel(),
        ],
      ),
    );
  }
}

class _CenterColumn extends StatelessWidget {
  const _CenterColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        HeroCard(),
        SizedBox(height: 14),
        MatchControlCard(),
        SizedBox(height: 14),
        _SeasonProgressCard(),
      ],
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TeamPanel(),
        SizedBox(height: 14),
        StorePanel(),
      ],
    );
  }
}

class _SeasonProgressCard extends StatelessWidget {
  const _SeasonProgressCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Season progress',
            trailing: Pill(
              text: 'SEASON 4',
              color: Color(0x22C8FF4D),
              textColor: AppColors.lime,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'DIVISION 3',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        '1,840 / 2,500 pts',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted.withValues(alpha: 0.95),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Pill(
                text: '#1,204',
                color: AppColors.surfaceAlt,
                textColor: AppColors.text,
                icon: Icons.public_rounded,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(height: 8, color: AppColors.surfaceAlt),
                const FractionallySizedBox(
                  widthFactor: 0.73,
                  child: SizedBox(
                    height: 8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.limeDark, AppColors.lime],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: _RewardTile(
                  icon: Icons.military_tech_rounded,
                  label: 'Promotion',
                  value: '660 pts left',
                  color: AppColors.gold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _RewardTile(
                  icon: Icons.card_giftcard_rounded,
                  label: 'Reward',
                  value: 'Legendary pack',
                  color: AppColors.lime,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
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
