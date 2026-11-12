import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import 'common.dart';

/// O'ng ustun: jamoa tarkibi va kuch ko'rsatkichlari.
class TeamPanel extends StatelessWidget {
  const TeamPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'My Team',
            trailing: Pill(
              text: MockData.formation,
              color: Color(0x22C8FF4D),
              textColor: AppColors.lime,
              icon: Icons.grid_view_rounded,
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final sideBySide = constraints.maxWidth >= 380;
              if (!sideBySide) {
                return const Column(
                  children: [
                    _Pitch(),
                    SizedBox(height: 16),
                    _TeamStats(),
                  ],
                );
              }
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _Pitch()),
                  SizedBox(width: 16),
                  SizedBox(width: 178, child: _TeamStats()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TeamStats extends StatelessWidget {
  const _TeamStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  MockData.teamPower,
                  style: TextStyle(
                    fontSize: 32,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Pill(
              text: '+4.2',
              color: Color(0x22C8FF4D),
              textColor: AppColors.lime,
              icon: Icons.trending_up_rounded,
              fontSize: 9,
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Team Power',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Top 4% worldwide',
          style: TextStyle(fontSize: 10, color: AppColors.muted),
        ),
        const SizedBox(height: 16),
        for (final stat in MockData.stats) ...[
          StatBar(
            label: stat.label,
            value: stat.value,
            color: stat.color,
            valueLabel: '${(stat.value * 100).round()}',
          ),
          if (stat != MockData.stats.last) const SizedBox(height: 11),
        ],
        const SizedBox(height: 16),
        const Divider(height: 1, color: AppColors.strokeSoft),
        const SizedBox(height: 12),
        Row(
          children: const [
            Icon(Icons.groups_2_outlined, size: 15, color: AppColors.muted),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Formation',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.5, color: AppColors.muted),
              ),
            ),
            SizedBox(width: 5),
            Text(
              MockData.formation,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        PrimaryButton(
          label: 'Manage squad',
          icon: Icons.tune_rounded,
          onPressed: () {},
          color: AppColors.surfaceAlt,
          foreground: AppColors.text,
          expand: true,
        ),
      ],
    );
  }
}

class _Pitch extends StatelessWidget {
  const _Pitch();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.82,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.pitchAlt, AppColors.pitch],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Stack(
          children: [
            // Maydon chiziqlari.
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(6),
                child: CustomPaint(painter: PitchPainter()),
              ),
            ),
            // Yorug'lik effekti.
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.5),
                      radius: 1.1,
                      colors: [
                        Colors.white.withValues(alpha: 0.07),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            for (final player in MockData.players)
              Align(
                alignment: player.alignment,
                child: PlayerChip(player: player),
              ),
          ],
        ),
      ),
    );
  }
}

/// Maydondagi o'yinchi belgisi.
class PlayerChip extends StatelessWidget {
  const PlayerChip({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              GradientAvatar(
                label: player.initials,
                color: player.color,
                size: 32,
              ),
              Positioned(
                top: -5,
                right: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${player.rating}',
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: AppColors.bgDeep,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -4,
                left: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgDeep.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    player.position,
                    style: const TextStyle(
                      fontSize: 6.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ],
      ),
    );
  }
}
