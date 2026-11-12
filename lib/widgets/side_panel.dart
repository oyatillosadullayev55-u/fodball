import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import 'common.dart';

/// Chap ustun: profil, navigatsiya, iqtibos va jonli o'yin.
class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _ProfileCard(),
        SizedBox(height: 14),
        _MenuList(),
        SizedBox(height: 14),
        _LiveMatchCard(),
        SizedBox(height: 14),
        _QuoteCard(),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const GradientAvatar(
                label: 'OA',
                color: AppColors.lime,
                size: 52,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MockData.userName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Real Madrid • Pro League',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              CircleIconButton(
                icon: Icons.settings_outlined,
                size: 32,
                tooltip: 'Settings',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Level ${MockData.level}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  '6,240 / 9,000 XP',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(height: 6, color: AppColors.surfaceAlt),
                const FractionallySizedBox(
                  widthFactor: 0.69,
                  child: SizedBox(
                    height: 6,
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
          const SizedBox(height: 16),
          Row(
            children: const [
              _MiniStat(value: '128', label: 'Matches'),
              _MiniStat(value: '92', label: 'Wins'),
              _MiniStat(value: '7', label: 'Trophies', accent: AppColors.gold),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.value,
    required this.label,
    this.accent = AppColors.text,
  });

  final String value;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 1,
              color: accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < MockData.menu.length; i++) ...[
          _MenuTile(entry: MockData.menu[i]),
          if (i != MockData.menu.length - 1) const SizedBox(height: 9),
        ],
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.entry});

  final MenuEntry entry;

  @override
  Widget build(BuildContext context) {
    final highlighted = entry.highlighted;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: highlighted
                ? const LinearGradient(
                    colors: [AppColors.lime, AppColors.limeDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: highlighted ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: highlighted ? Colors.transparent : AppColors.strokeSoft,
            ),
            boxShadow: highlighted
                ? [
                    BoxShadow(
                      color: AppColors.lime.withValues(alpha: 0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: highlighted
                      ? AppColors.bgDeep.withValues(alpha: 0.16)
                      : AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  entry.icon,
                  size: 19,
                  color: highlighted ? AppColors.bgDeep : AppColors.lime,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                        color: highlighted ? AppColors.bgDeep : AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: highlighted
                            ? AppColors.bgDeep.withValues(alpha: 0.72)
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: highlighted
                    ? AppColors.bgDeep.withValues(alpha: 0.7)
                    : AppColors.mutedDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveMatchCard extends StatelessWidget {
  const _LiveMatchCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF131F3B), Color(0xFF0A1120)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Pill(
                text: 'LIVE',
                color: Color(0x33FF4D5E),
                textColor: AppColors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'La Liga • Matchday 12',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.muted.withValues(alpha: 0.95),
                  ),
                ),
              ),
              const Icon(
                Icons.more_horiz_rounded,
                size: 18,
                color: AppColors.muted,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const _TeamCrest(code: 'RMA', color: Color(0xFFF5F8FF)),
              const Expanded(
                child: Column(
                  children: [
                    Text(
                      '0 : 0',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 12,
                          color: AppColors.muted,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '15:24',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const _TeamCrest(code: 'FCB', color: Color(0xFF2F6BFF)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 58,
                child: Container(
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                flex: 42,
                child: Container(
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text(
                'Possession 58%',
                style: TextStyle(fontSize: 10, color: AppColors.muted),
              ),
              Spacer(),
              Text(
                '42%',
                style: TextStyle(fontSize: 10, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const PrimaryButton(
            label: 'Watch match',
            icon: Icons.play_arrow_rounded,
            expand: true,
          ),
        ],
      ),
    );
  }
}

class _TeamCrest extends StatelessWidget {
  const _TeamCrest({required this.code, required this.color});

  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.14),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          code,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface.withValues(alpha: 0.55),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            size: 28,
            color: AppColors.lime,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Football unites us.',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Build your legacy, one match at a time.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: AppColors.muted.withValues(alpha: 0.9),
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
