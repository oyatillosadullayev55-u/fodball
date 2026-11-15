import 'package:flutter/material.dart';

import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';

/// Klub gerbi — stilizatsiya halqali badge.
class ClubCrest extends StatelessWidget {
  const ClubCrest({super.key, required this.club, this.size = 34});

  final Club club;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            club.crestColors[0],
            club.crestColors[1],
            club.crestColors[0],
            club.crestColors[1],
            club.crestColors[0],
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.75), width: 1.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size * 0.62,
          height: size * 0.62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0B1426),
            border: Border.all(
              color: club.crestColors[0].withValues(alpha: 0.9),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              club.short,
              style: TextStyle(
                fontSize: size * 0.22,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Valyuta pillasi: coins yoki gems.
class CurrencyPill extends StatelessWidget {
  const CurrencyPill({
    super.key,
    required this.icon,
    required this.value,
    required this.color,
    this.onAdd,
  });

  final IconData icon;
  final String value;
  final Color color;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 110),
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: AppColors.text,
                ),
              ),
            ),
            if (onAdd != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 12, color: Color(0xFF0A0F1E)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Yuqori paneldagi valyutalar bloki (GameState dan o'qiydi).
class CurrencyBar extends StatelessWidget {
  const CurrencyBar({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CurrencyPill(
              icon: Icons.monetization_on_rounded,
              value: _format(state.coins),
              color: AppColors.gold,
              onAdd: () => Navigator.of(context).pushNamed('/store'),
            ),
          ),
          if (!compact) const SizedBox(width: 8),
          if (!compact)
            Flexible(
              child: CurrencyPill(
                icon: Icons.diamond_rounded,
                value: _format(state.gems),
                color: AppColors.violet,
                onAdd: () => Navigator.of(context).pushNamed('/store'),
              ),
            ),
        ],
      ),
    );
  }

  static String _format(int v) {
    if (v >= 1000000) {
      final m = v / 1000000;
      return '${m == m.roundToDouble() ? m.toStringAsFixed(0) : m.toStringAsFixed(1)}M';
    }
    if (v >= 1000) {
      final k = v / 1000;
      return '${k == k.roundToDouble() ? k.toStringAsFixed(0) : k.toStringAsFixed(1)}K';
    }
    return '$v';
  }
}

/// Shaffof qorako'k panel.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 18,
    this.alpha = 0.62,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF16233F).withValues(alpha: alpha),
            const Color(0xFF0A1120).withValues(alpha: alpha),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Bo'lim sarlavhasi.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.2,
              color: AppColors.text,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// Bayroq halqasi — 2 rangli doira.
class FlagDot extends StatelessWidget {
  const FlagDot({super.key, required this.colors, this.size = 10});

  final List<Color> colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [colors[0], colors[1], colors[0]],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
      ),
    );
  }
}

/// O'yinchi kartasi (eFootball uslubida): rating, pozitsiya, portret, ism, bayroq.
class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.player,
    this.width = 78,
    this.showName = true,
    this.selected = false,
  });

  final Player player;
  final double width;
  final bool showName;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final h = width * 1.42;
    final ratingColor = player.rating >= 95
        ? AppColors.gold
        : player.rating >= 90
            ? AppColors.violet
            : AppColors.blue;
    return Container(
      width: width,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            player.color.withValues(alpha: 0.85),
            const Color(0xFF0A1120),
          ],
        ),
        border: Border.all(
          color: selected
              ? AppColors.lime
              : Colors.white.withValues(alpha: 0.14),
          width: selected ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: player.color.withValues(alpha: 0.25),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 6,
            top: 4,
            child: Text(
              '${player.rating}',
              style: TextStyle(
                fontSize: width * 0.19,
                height: 1,
                fontWeight: FontWeight.w900,
                color: ratingColor,
              ),
            ),
          ),
          Positioned(
            right: 6,
            top: 5,
            child: Text(
              player.position,
              style: TextStyle(
                fontSize: width * 0.11,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
          Center(
            child: Container(
              width: width * 0.42,
              height: width * 0.42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
              child: Center(
                child: Text(
                  player.initials,
                  style: TextStyle(
                    fontSize: width * 0.15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (showName)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(9),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        player.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.105,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    FlagDot(colors: player.flag, size: width * 0.1),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Yuklab olish tugmachasi.
void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}
