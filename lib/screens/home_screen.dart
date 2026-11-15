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
                  const Color(0xFF02050C).withValues(alpha: 0.55),
                  const Color(0xFF02050C).withValues(alpha: 0.25),
                  const Color(0xFF02050C).withValues(alpha: 0.82),
                ],
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 1150;
                final content = wide
                    ? _WideLayout(onPlay: () => _startMatch(context))
                    : _NarrowLayout(onPlay: () => _startMatch(context));
                return Column(
                  children: [
                    const _TopBar(),
                    Expanded(child: content),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startMatch(BuildContext context) {
    pushScreen(context, const MatchScreen(match: MockData.nextMatch));
  }
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
            final showProfile = constraints.maxWidth >= 780;
            return Row(
              children: [
                const _Logo(),
                if (showProfile) ...[
                  const SizedBox(width: 14),
                  const _Profile(),
                  const SizedBox(width: 14),
                  _LevelBadge(
                      level: state.level, xp: state.xp, xpMax: state.xpMax),
                ],
                const Spacer(),
                const Flexible(child: CurrencyBar()),
                const SizedBox(width: 10),
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
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.5)),
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.gold,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
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
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lime.withValues(alpha: 0.5),
                  AppColors.blue.withValues(alpha: 0.5),
                ],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              image: const DecorationImage(
                image: AssetImage('assets/images/hero_player.png'),
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.userName,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Manager',
                style: TextStyle(fontSize: 9.5, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(width: 8),
          ClubCrest(club: state.userClub, size: 28),
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
        Text(
          'LV. $level',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
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
                  constraints: const BoxConstraints(minWidth: 13, minHeight: 13),
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
    );
  }
}

// -----------------------------------------------------------------------------
// Chap menyu
// -----------------------------------------------------------------------------

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.highlighted = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool highlighted;
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem(
        title: 'Career Mode',
        subtitle: 'Build your legacy',
        icon: Icons.sports_soccer_rounded,
        onTap: () => pushScreen(context, const CareerScreen()),
        highlighted: true,
      ),
      _MenuItem(
        title: 'Tournaments',
        subtitle: 'Win prestigious cups',
        icon: Icons.emoji_events_rounded,
        onTap: () => pushScreen(context, const TournamentsScreen()),
      ),
      _MenuItem(
        title: 'Play Match',
        subtitle: 'Quick & Online',
        icon: Icons.play_circle_rounded,
        onTap: onPlay,
      ),
      _MenuItem(
        title: 'Store',
        subtitle: 'Get amazing rewards',
        icon: Icons.shopping_cart_rounded,
        onTap: () => pushScreen(context, const StoreScreen()),
      ),
      _MenuItem(
        title: 'My Club',
        subtitle: 'Manage your team',
        icon: Icons.bar_chart_rounded,
        onTap: () => pushScreen(context, const TeamScreen()),
      ),
      _MenuItem(
        title: 'Settings',
        subtitle: 'Customize game',
        icon: Icons.settings_rounded,
        onTap: () => pushScreen(context, const SettingsScreen()),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _MenuButton(item: item),
          ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.item});

  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    final highlight = item.highlighted;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: highlight
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFD23F), Color(0xFFF5A623)],
                  )
                : null,
            color: highlight ? null : const Color(0xFF0B1426).withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: highlight
                  ? AppColors.gold
                  : Colors.white.withValues(alpha: 0.10),
            ),
            boxShadow: highlight
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.3),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: highlight
                      ? Colors.black.withValues(alpha: 0.2)
                      : item.title == 'Play Match'
                          ? AppColors.gold.withValues(alpha: 0.18)
                          : Colors.white.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: highlight
                      ? const Color(0xFF241A02)
                      : item.title == 'Play Match'
                          ? AppColors.gold
                          : AppColors.lime,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: highlight ? const Color(0xFF241A02) : AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: highlight
                            ? const Color(0xFF241A02).withValues(alpha: 0.75)
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: highlight
                    ? const Color(0xFF241A02)
                    : Colors.white.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Keng layout (desktop / planshet)
// -----------------------------------------------------------------------------

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 262,
                  child: _SideMenu(onPlay: onPlay),
                ),
                const SizedBox(width: 14),
                const Expanded(child: _HeroPanel()),
                const SizedBox(width: 14),
                const SizedBox(width: 316, child: _RightColumn()),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const _FeatureCards(),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Column(
        children: [
          _SideMenu(onPlay: onPlay),
          const SizedBox(height: 12),
          const SizedBox(height: 250, child: _HeroPanel()),
          const SizedBox(height: 12),
          const SizedBox(height: 240, child: _NextMatchCard()),
          const SizedBox(height: 12),
          const SizedBox(height: 260, child: _StandingsCard()),
          const SizedBox(height: 12),
          const _FeatureCards(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Markaziy hero
// -----------------------------------------------------------------------------

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/hero_player.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0.35, -0.3),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF02050C).withValues(alpha: 0.75),
                    const Color(0xFF02050C).withValues(alpha: 0.1),
                    const Color(0xFF02050C).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 26,
              bottom: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DREAM BIG',
                    style: TextStyle(
                      fontSize: 40,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 18),
                      ],
                    ),
                  ),
                  Text(
                    'ACHIEVE MORE',
                    style: TextStyle(
                      fontSize: 40,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontStyle: FontStyle.italic,
                      color: AppColors.gold,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 18),
                      ],
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

// -----------------------------------------------------------------------------
// O'ng ustun: Next Match + jadval
// -----------------------------------------------------------------------------

class _RightColumn extends StatelessWidget {
  const _RightColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: _NextMatchCard()),
        SizedBox(height: 12),
        Expanded(child: _StandingsCard()),
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
          const Text(
            'Next Match',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _MatchClub(club: match.home)),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: AppColors.muted,
                ),
              ),
              Expanded(child: _MatchClub(club: match.away)),
            ],
          ),
          const SizedBox(height: 6),
          const Icon(Icons.emoji_events_outlined,
              size: 15, color: AppColors.blue),
          const SizedBox(height: 2),
          Center(
            child: Text(
              match.competition,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.6,
                color: AppColors.blue,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month_rounded,
                  size: 13, color: AppColors.muted),
              const SizedBox(width: 5),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${match.dateLabel}  |  ${match.timeLabel}',
                    style: const TextStyle(fontSize: 11, color: AppColors.muted),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _StartMatchButton(
            onTap: () => pushScreen(
              context,
              const MatchScreen(match: MockData.nextMatch),
            ),
          ),
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
        ClubCrest(club: club, size: 46),
        const SizedBox(height: 6),
        Text(
          club.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
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
      color: AppColors.gold,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.35),
                blurRadius: 14,
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Start Match',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF241A02),
                ),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: Color(0xFF241A02),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < state.table.length; i++)
                      _StandingRow(
                        index: i + 1,
                        standing: state.table[i],
                      ),
                  ],
                ),
              ),
            ),
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
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.blue.withValues(alpha: 0.28)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
        border: isUser
            ? Border.all(color: AppColors.blue.withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text(
              '$index',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.muted,
              ),
            ),
          ),
          ClubCrest(club: standing.club, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              standing.club.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
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
              style: const TextStyle(fontSize: 11.5, color: AppColors.text),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${standing.points}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11.5,
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

// -----------------------------------------------------------------------------
// Pastki kartalar
// -----------------------------------------------------------------------------

class _FeatureCards extends StatelessWidget {
  const _FeatureCards();

  @override
  Widget build(BuildContext context) {
    const height = 118.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: _FeatureCard(
              title: 'Player Career',
              subtitle: 'Grow into a legend',
              image: 'assets/images/hero_player.png',
              icon: Icons.person_rounded,
              onTap: () => pushScreen(context, const CareerScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Transfers',
              subtitle: 'Buy & Sell Players',
              image: 'assets/images/stadium_bg.png',
              icon: Icons.handshake_rounded,
              onTap: () => pushScreen(context, const TransfersScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Training',
              subtitle: 'Improve Your Team',
              image: 'assets/images/stadium_bg.png',
              icon: Icons.sports_rounded,
              onTap: () => pushScreen(context, const TrainingScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FeatureCard(
              title: 'Achievements',
              subtitle: 'Complete Missions',
              image: 'assets/images/champions_bg.png',
              icon: Icons.military_tech_rounded,
              badge: '12',
              onTap: () => pushScreen(context, const AchievementsScreen()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: _FeatureCard(
              title: 'CHAMPIONS\nLEAGUE',
              subtitle: 'The ultimate stage',
              image: 'assets/images/champions_bg.png',
              icon: Icons.emoji_events_rounded,
              onTap: () => pushScreen(context, const TournamentsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String subtitle;
  final String image;
  final IconData icon;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(image, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                    ),
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          fontSize: 9,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(icon, size: 15, color: AppColors.lime),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12.5,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
