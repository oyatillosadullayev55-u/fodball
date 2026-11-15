import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'achievements_screen.dart';
import 'career_screen.dart';
import 'match_screen.dart';
import 'settings_screen.dart';
import 'store_screen.dart';
import 'team_screen.dart';
import 'tournaments_screen.dart';
import 'training_screen.dart';
import 'transfers_screen.dart';

/// Asosiy menyu — Football Legends uslubida.
///
/// Ekran hech qachon scroll qilmaydi: barcha bo'limlarga faqat tugma bosish
/// orqali o'tiladi va tarkib har qanday ekran o'lchamiga sig'adi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF02050C).withValues(alpha: 0.72),
                  const Color(0xFF02050C).withValues(alpha: 0.48),
                  const Color(0xFF02050C).withValues(alpha: 0.88),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final wide = w >= 1120;
                      final compact = w >= 620;
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          wide ? 16 : 12,
                          wide ? 8 : 4,
                          wide ? 16 : 12,
                          wide ? 14 : 10,
                        ),
                        child: wide
                            ? const _WideBody()
                            : (compact
                                ? const _CompactBody()
                                : const _PortraitBody()),
                      );
                    },
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

void _startMatch(BuildContext context) {
  pushScreen(context, const MatchScreen(match: MockData.nextMatch));
}

// -----------------------------------------------------------------------------
// Yuqori panel
// -----------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
      child: AnimatedBuilder(
        animation: state,
        builder: (context, _) => LayoutBuilder(
          builder: (context, constraints) {
            final showProfile = constraints.maxWidth >= 860;
            final narrow = constraints.maxWidth < 480;
            return Row(
              children: [
                _Logo(showText: !narrow),
                if (showProfile) ...[
                  const SizedBox(width: 14),
                  const _Profile(),
                  const SizedBox(width: 12),
                  _LevelBadge(
                      level: state.level, xp: state.xp, xpMax: state.xpMax),
                ],
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: CurrencyBar(compact: narrow),
                ),
                SizedBox(width: narrow ? 8 : 10),
                _IconBadge(
                  icon: Icons.notifications_rounded,
                  count: state.notifications,
                  onTap: () {
                    state.clearNotifications();
                    pushScreen(context, const AchievementsScreen());
                  },
                ),
                const SizedBox(width: 8),
                _IconBadge(
                  icon: Icons.settings_rounded,
                  onTap: () => pushScreen(context, const SettingsScreen()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({this.showText = true});

  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gold.withValues(alpha: 0.28),
                AppColors.gold.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.55)),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.18),
                blurRadius: 14,
              ),
            ],
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.gold,
            size: 22,
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 9),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'FOOTBALL',
                style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                  color: AppColors.text,
                ),
              ),
              Text(
                'LEGENDS',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 4, 10, 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lime, AppColors.blue],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.65)),
              image: const DecorationImage(
                image: AssetImage('assets/images/hero_player.png'),
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.35),
              ),
            ),
          ),
          const SizedBox(width: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.userName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Manager',
                  style: TextStyle(fontSize: 9, color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ClubCrest(club: state.userClub, size: 24),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level, required this.xp, required this.xpMax});

  final int level;
  final int xp;
  final int xpMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blue.withValues(alpha: 0.28),
                AppColors.violet.withValues(alpha: 0.18),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.blue.withValues(alpha: 0.45)),
          ),
          child: Text(
            'LV. $level',
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 92,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (xp / xpMax).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.blue, Color(0xFF4DE1FF)],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'XP ${_format(xp)} / ${_format(xpMax)}',
              style: const TextStyle(fontSize: 8.5, color: AppColors.muted),
            ),
          ],
        ),
      ],
    );
  }

  static String _format(int v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return '$v';
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, this.count = 0, this.onTap});

  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: 17, color: AppColors.text),
              if (count > 0)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 13, minHeight: 13),
                    child: Center(
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 7.5,
                          height: 1,
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
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Menyu bandlari
// -----------------------------------------------------------------------------

class _MenuEntry {
  const _MenuEntry({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle = '',
    this.accent = AppColors.lime,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color accent;
}

List<_MenuEntry> _menuEntries(BuildContext context) => [
      _MenuEntry(
        title: 'Career Mode',
        subtitle: 'Build your legacy',
        icon: Icons.sports_soccer_rounded,
        accent: AppColors.gold,
        onTap: () => pushScreen(context, const CareerScreen()),
      ),
      _MenuEntry(
        title: 'Tournaments',
        subtitle: 'Win prestigious cups',
        icon: Icons.emoji_events_rounded,
        accent: AppColors.gold,
        onTap: () => pushScreen(context, const TournamentsScreen()),
      ),
      _MenuEntry(
        title: 'My Club',
        subtitle: 'Manage your team',
        icon: Icons.shield_rounded,
        accent: AppColors.blue,
        onTap: () => pushScreen(context, const TeamScreen()),
      ),
      _MenuEntry(
        title: 'Store',
        subtitle: 'Packs & rewards',
        icon: Icons.shopping_bag_rounded,
        accent: AppColors.violet,
        onTap: () => pushScreen(context, const StoreScreen()),
      ),
      _MenuEntry(
        title: 'Transfers',
        subtitle: 'Buy & sell stars',
        icon: Icons.handshake_rounded,
        accent: AppColors.lime,
        onTap: () => pushScreen(context, const TransfersScreen()),
      ),
      _MenuEntry(
        title: 'Training',
        subtitle: 'Improve your squad',
        icon: Icons.fitness_center_rounded,
        accent: AppColors.red,
        onTap: () => pushScreen(context, const TrainingScreen()),
      ),
    ];

// -----------------------------------------------------------------------------
// Layoutlar — scroll yo'q, faqat tugmalar
// -----------------------------------------------------------------------------

class _WideBody extends StatelessWidget {
  const _WideBody();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 258, child: _SideMenu(entries: _menuEntries(context))),
        const SizedBox(width: 14),
        Expanded(child: _HeroPanel(onPlay: () => _startMatch(context))),
        const SizedBox(width: 14),
        const SizedBox(width: 320, child: _RightColumn()),
      ],
    );
  }
}

class _CompactBody extends StatelessWidget {
  const _CompactBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _HeroPanel(onPlay: () => _startMatch(context))),
        const SizedBox(height: 10),
        _MenuStrip(entries: _menuEntries(context)),
      ],
    );
  }
}

class _PortraitBody extends StatelessWidget {
  const _PortraitBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _HeroPanel(onPlay: () => _startMatch(context))),
        const SizedBox(height: 10),
        SizedBox(height: 236, child: _MenuGrid(entries: _menuEntries(context))),
      ],
    );
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({required this.entries});

  final List<_MenuEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Expanded(child: _SideButton(entry: entries[i])),
        ],
      ],
    );
  }
}

class _SideButton extends StatelessWidget {
  const _SideButton({required this.entry});

  final _MenuEntry entry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: entry.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFF16233F).withValues(alpha: 0.92),
                const Color(0xFF0B1426).withValues(alpha: 0.82),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      entry.accent.withValues(alpha: 0.35),
                      entry.accent.withValues(alpha: 0.08),
                    ],
                  ),
                  border:
                      Border.all(color: entry.accent.withValues(alpha: 0.5)),
                ),
                child: Icon(entry.icon, size: 17, color: entry.accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: Colors.white.withValues(alpha: 0.32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuStrip extends StatelessWidget {
  const _MenuStrip({required this.entries});

  final List<_MenuEntry> entries;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: Row(
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(child: _MenuTile(entry: entries[i], dense: true)),
          ],
        ],
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({required this.entries});

  final List<_MenuEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var row = 0; row < 3; row++) ...[
          if (row > 0) const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _MenuTile(entry: entries[row * 2], dense: true)),
                const SizedBox(width: 8),
                Expanded(
                  child: _MenuTile(entry: entries[row * 2 + 1], dense: true),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.entry, this.dense = false});

  final _MenuEntry entry;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: entry.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: dense ? 8 : 12,
            vertical: dense ? 8 : 10,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A2744).withValues(alpha: 0.94),
                const Color(0xFF0A1220).withValues(alpha: 0.90),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.32),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: entry.accent.withValues(alpha: 0.10),
                blurRadius: 16,
              ),
            ],
          ),
          child: dense
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _IconBubble(entry: entry, size: 32, iconSize: 17),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        entry.title,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    _IconBubble(entry: entry, size: 34, iconSize: 17),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            entry.subtitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: Colors.white.withValues(alpha: 0.30),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.entry,
    required this.size,
    required this.iconSize,
  });

  final _MenuEntry entry;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            entry.accent.withValues(alpha: 0.38),
            entry.accent.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: entry.accent.withValues(alpha: 0.5)),
      ),
      child: Icon(entry.icon, size: iconSize, color: entry.accent),
    );
  }
}

// -----------------------------------------------------------------------------
// Markaziy hero
// -----------------------------------------------------------------------------

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/hero_player.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0.55, -0.2),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xFF02050C).withValues(alpha: 0.94),
                    const Color(0xFF02050C).withValues(alpha: 0.58),
                    const Color(0xFF02050C).withValues(alpha: 0.08),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF02050C).withValues(alpha: 0.42),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final dense = constraints.maxHeight < 300;
                  return dense
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _HeroCopy(
                                dense: true,
                                onPlay: onPlay,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 2,
                              child: _NextUpStrip(dense: true),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _CompetitionChip(),
                            const Spacer(),
                            SizedBox(
                              width: constraints.maxWidth,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: _HeroTitle(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _PlayButton(onTap: onPlay),
                            const Spacer(),
                            _NextUpStrip(),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.dense, required this.onPlay});

  final bool dense;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CompetitionChip(),
        SizedBox(height: dense ? 6 : 12),
        const Flexible(child: FittedBox(fit: BoxFit.scaleDown, child: _HeroTitle())),
        SizedBox(height: dense ? 8 : 16),
        _PlayButton(onTap: onPlay, dense: dense),
      ],
    );
  }
}

class _CompetitionChip extends StatelessWidget {
  const _CompetitionChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.5)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 12, color: AppColors.blue),
          SizedBox(width: 5),
          Text(
            'CHAMPIONS LEAGUE • FINAL',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
              color: Color(0xFFBFD0FF),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'DREAM BIG',
          style: TextStyle(
            fontSize: 38,
            height: 0.95,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black87, blurRadius: 18)],
          ),
        ),
        Text(
          'ACHIEVE MORE',
          style: TextStyle(
            fontSize: 38,
            height: 1.05,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            fontStyle: FontStyle.italic,
            color: AppColors.gold,
            shadows: [
              Shadow(color: Colors.black87, blurRadius: 18),
              Shadow(color: Color(0x66FFC542), blurRadius: 26),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.onTap, this.dense = false});

  final VoidCallback onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: dense ? 18 : 22,
            vertical: dense ? 10 : 13,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD75E), Color(0xFFF5A623)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.42),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF241A02).withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    size: 16, color: Color(0xFF241A02)),
              ),
              const SizedBox(width: 7),
              Text(
                'Start Match',
                style: TextStyle(
                  fontSize: dense ? 13 : 14.5,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF241A02),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded,
                  size: 18, color: Color(0xFF241A02)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextUpStrip extends StatelessWidget {
  const _NextUpStrip({this.dense = false});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final match = MockData.nextMatch;
    return Container(
      padding: EdgeInsets.all(dense ? 10 : 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.55),
            Colors.black.withValues(alpha: 0.32),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'NEXT UP',
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.8,
              color: AppColors.muted,
            ),
          ),
          SizedBox(height: dense ? 5 : 8),
          Row(
            children: [
              Expanded(child: _ClubMini(club: match.home, size: dense ? 26 : 34)),
              Text(
                'VS',
                style: TextStyle(
                  fontSize: dense ? 11 : 13,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: AppColors.muted,
                ),
              ),
              Expanded(child: _ClubMini(club: match.away, size: dense ? 26 : 34)),
            ],
          ),
          SizedBox(height: dense ? 5 : 7),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${match.timeLabel}  •  ${match.dateLabel}',
              maxLines: 1,
              style: TextStyle(
                fontSize: dense ? 9 : 10,
                fontWeight: FontWeight.w700,
                color: AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClubMini extends StatelessWidget {
  const _ClubMini({required this.club, required this.size});

  final Club club;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClubCrest(club: club, size: size),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            club.short,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// O'ng ustun: Next Match + jadval
// -----------------------------------------------------------------------------

class _RightColumn extends StatelessWidget {
  const _RightColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(flex: 5, child: _NextMatchCard()),
        SizedBox(height: 12),
        Expanded(flex: 6, child: _StandingsCard()),
      ],
    );
  }
}

class _NextMatchCard extends StatelessWidget {
  const _NextMatchCard();

  @override
  Widget build(BuildContext context) {
    final match = MockData.nextMatch;
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Text(
                'Next Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.text,
                ),
              ),
              Spacer(),
              Icon(Icons.bolt_rounded, size: 16, color: AppColors.gold),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _MatchClub(club: match.home)),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: AppColors.muted,
                  ),
                ),
                Expanded(child: _MatchClub(club: match.away)),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
              ),
              child: Text(
                match.competition,
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                  color: Color(0xFFBFD0FF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month_rounded,
                  size: 12, color: AppColors.muted),
              const SizedBox(width: 5),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${match.dateLabel}  |  ${match.timeLabel}',
                    style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _StartMatchButton(onTap: () => _startMatch(context)),
        ],
      ),
    );
  }
}

class _MatchClub extends StatelessWidget {
  const _MatchClub({required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClubCrest(club: club, size: 44),
        const SizedBox(height: 6),
        Text(
          club.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _StartMatchButton extends StatelessWidget {
  const _StartMatchButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD75E), Color(0xFFF5A623)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, size: 18, color: Color(0xFF241A02)),
              SizedBox(width: 4),
              Text(
                'Play Match',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF241A02),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StandingsCard extends StatelessWidget {
  const _StandingsCard();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: AnimatedBuilder(
        animation: state,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionTitle('League Standings'),
            const SizedBox(height: 8),
            const Row(
              children: [
                SizedBox(width: 18, child: _Head('#')),
                Expanded(child: _Head('Club')),
                SizedBox(width: 30, child: _Head('P', align: TextAlign.center)),
                SizedBox(width: 30, child: _Head('Pts', align: TextAlign.right)),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < state.table.length && i < 5; i++)
                    Expanded(
                      child: _StandingRow(
                        index: i + 1,
                        standing: state.table[i],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'LALIGA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head(this.text, {this.align = TextAlign.left});

  final String text;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: const TextStyle(
        fontSize: 9.5,
        fontWeight: FontWeight.w800,
        color: AppColors.muted,
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  const _StandingRow({required this.index, required this.standing});

  final int index;
  final Standing standing;

  @override
  Widget build(BuildContext context) {
    final isUser = standing.isUser;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.blue.withValues(alpha: 0.30)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
        border: isUser
            ? Border.all(color: AppColors.blue.withValues(alpha: 0.55))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: isUser ? AppColors.text : AppColors.muted,
              ),
            ),
          ),
          ClubCrest(club: standing.club, size: 15),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              standing.club.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isUser ? FontWeight.w900 : FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${standing.played}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: AppColors.text),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${standing.points}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
