import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../game3d/game_painter.dart';
import '../game3d/penalty_game.dart';
import '../theme/app_colors.dart';
import 'dashboard_screen.dart';

/// 3D penalti o'yini ekrani.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late final PenaltyGame _game = PenaltyGame();
  late final GamePainter _painter = GamePainter(_game);
  late final Ticker _ticker;
  Duration _last = Duration.zero;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1000000.0;
    _last = elapsed;
    if (dt > 0 && dt < 0.25) _game.tick(dt);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _game.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _openClub() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(child: CustomPaint(painter: _painter)),

          // Dekorativ HUD (tugmalarni o'z ichiga olmaydi).
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _game,
              builder: (context, _) => _Hud(game: _game),
            ),
          ),

          // O'yin kiritish qatlami.
          LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (d) => _game.tapShoot(d.localPosition, size),
                onPanStart: (d) => _game.beginAim(d.localPosition, size),
                onPanUpdate: (d) => _game.updateAim(d.localPosition, size),
                onPanEnd: (_) => _game.releaseShot(),
                onPanCancel: () => _game.releaseShot(),
              );
            },
          ),

          // Boshqaruv tugmalari.
          Positioned.fill(
            child: SafeArea(
              minimum: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _RoundButton(
                      icon: Icons.shield_rounded,
                      label: 'CLUB',
                      onTap: _openClub,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // O'yin tugagan ekran.
          AnimatedBuilder(
            animation: _game,
            builder: (context, _) => _GameOverOverlay(
              game: _game,
              onClub: _openClub,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HUD
// -----------------------------------------------------------------------------

class _Hud extends StatelessWidget {
  const _Hud({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(10),
      child: Stack(
        children: [
          const Positioned(left: 0, top: 0, child: _Brand()),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(child: _Scoreboard(game: game)),
          ),
          Positioned(left: 0, bottom: 0, child: _Hint(game: game)),
          Positioned(right: 0, bottom: 0, child: _PowerMeter(game: game)),
          Positioned.fill(child: Center(child: _ResultBanner(game: game))),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.lime,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sports_soccer_rounded,
              size: 15,
              color: AppColors.bgDeep,
            ),
          ),
          const SizedBox(width: 7),
          const Text(
            'FODBALL',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.6,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.lime.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '3D',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                color: AppColors.lime,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Metric(label: 'GOALS', value: '${game.goals}', color: AppColors.lime),
          const _Divider(),
          _Metric(
            label: 'SHOT',
            value: '${game.shotsTaken}/${PenaltyGame.totalShots}',
            color: AppColors.text,
          ),
          const _Divider(),
          _Metric(
            label: 'STREAK',
            value: '×${game.streak}',
            color: game.streak > 0 ? AppColors.gold : AppColors.muted,
          ),
          const SizedBox(width: 12),
          _ShotDots(history: game.history),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white.withValues(alpha: 0.10),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
            color: AppColors.muted.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            height: 1,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ShotDots extends StatelessWidget {
  const _ShotDots({required this.history});

  final List<String> history;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < PenaltyGame.totalShots; i++)
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i < history.length
                  ? switch (history[i]) {
                      'goal' => AppColors.lime,
                      'save' => AppColors.gold,
                      _ => AppColors.red,
                    }
                  : Colors.white.withValues(alpha: 0.16),
            ),
          ),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    final first = game.shotsTaken == 0;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: first ? 1 : 0.35,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.touch_app_rounded, size: 14, color: AppColors.lime),
            const SizedBox(width: 6),
            Text(
              first
                  ? 'Drag to aim · release to shoot'
                  : 'Aim for the corners',
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PowerMeter extends StatelessWidget {
  const _PowerMeter({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase != ShotPhase.aiming) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt_rounded, size: 14, color: AppColors.gold),
          const SizedBox(height: 5),
          Container(
            width: 9,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: game.power.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [AppColors.lime, AppColors.gold, AppColors.red],
                    ),
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

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({required this.game});

  final PenaltyGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase != ShotPhase.result || game.lastResult == null) {
      return const SizedBox.shrink();
    }
    final result = game.lastResult!;
    final color = switch (result) {
      'GOAL!' => AppColors.lime,
      'SAVED' => AppColors.gold,
      _ => AppColors.red,
    };
    final fade = (game.resultTimer / 0.4).clamp(0.0, 1.0);
    final pop = (1.35 - (game.resultTimer / 1.6) * 0.35).clamp(1.0, 1.35);

    return Opacity(
      opacity: fade,
      child: Transform.scale(
        scale: pop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              result,
              style: TextStyle(
                fontSize: 46,
                height: 1,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.2,
                color: color,
                shadows: [
                  Shadow(
                    color: color.withValues(alpha: 0.55),
                    blurRadius: 26,
                  ),
                ],
              ),
            ),
            if (result == 'GOAL!' && game.streak > 1) ...[
              const SizedBox(height: 6),
              Text(
                'STREAK ×${game.streak}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.2,
                  color: AppColors.text,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: AppColors.lime),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  color: AppColors.text,
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
// O'yin tugadi
// -----------------------------------------------------------------------------

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.game, required this.onClub});

  final PenaltyGame game;
  final VoidCallback onClub;

  @override
  Widget build(BuildContext context) {
    if (!game.isOver) return const IgnorePointer(child: SizedBox.shrink());

    final accuracy = game.shotsTaken == 0
        ? 0
        : (game.goals / game.shotsTaken * 100).round();

    return Container(
      color: Colors.black.withValues(alpha: 0.62),
      alignment: Alignment.center,
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF16233F), Color(0xFF0A1120)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.lime.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.lime.withValues(alpha: 0.18),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FULL TIME',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${game.goals} / ${PenaltyGame.totalShots}',
              style: const TextStyle(
                fontSize: 46,
                height: 1,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              accuracy >= 60 ? 'Striker of the match 🔥' : 'Keep practising!',
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatChip(label: 'ACCURACY', value: '$accuracy%'),
                const SizedBox(width: 8),
                _StatChip(label: 'BEST STREAK', value: '×${game.bestStreak}'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'PLAY AGAIN',
                    icon: Icons.replay_rounded,
                    filled: true,
                    onTap: game.restart,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    label: 'CLUB',
                    icon: Icons.shield_rounded,
                    filled: false,
                    onTap: onClub,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.lime : Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: filled
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15,
                color: filled ? AppColors.bgDeep : AppColors.text,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  color: filled ? AppColors.bgDeep : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
