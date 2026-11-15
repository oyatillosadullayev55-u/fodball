import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../data/mock_data.dart';
import '../game3d/match_game.dart';
import '../game3d/match_painter.dart';
import '../game3d/vec3.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'champions_screen.dart';

/// To'liq 3D match ekrani: joystick, PASS/SHOOT/SPRINT, hisob, minimap.
class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key, required this.match});

  final MatchInfo match;

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen>
    with SingleTickerProviderStateMixin {
  late final MatchGame _game;
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  bool _rewardsApplied = false;
  bool _championsShown = false;
  bool _gameReady = false;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_gameReady) return;
    _gameReady = true;
    final state = GameStateScope.of(context);
    _game = MatchGame(
      homeNames: [
        for (final p in state.squad)
          (
            name: p.name,
            number: p.number,
            pace: p.pace,
            shooting: p.shooting,
            passing: p.passing,
          ),
      ],
      awayNames: _awayRoster(),
    );
    _ticker = createTicker(_onTick)..start();
  }

  List<({String name, int number, int pace, int shooting, int passing})>
      _awayRoster() {
    final pool = MockData.packPool;
    return [
      for (var i = 0; i < 11; i++)
        (
          name: pool[i % pool.length].name,
          number: pool[i % pool.length].number,
          pace: pool[i % pool.length].pace,
          shooting: pool[i % pool.length].shooting,
          passing: pool[i % pool.length].passing,
        ),
    ];
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1000000.0;
    _last = elapsed;
    if (_paused) return;
    if (dt > 0 && dt < 0.25) _game.tick(dt);
    if (_game.isFullTime && !_rewardsApplied) _applyResult();
    if (_game.isFullTime &&
        widget.match.isFinal &&
        _game.scoreHome > _game.scoreAway &&
        !_championsShown) {
      _championsShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChampionsScreen()),
        );
      });
    }
  }

  void _applyResult() {
    _rewardsApplied = true;
    final state = GameStateScope.of(context);
    state.recordMatchResult(
      won: _game.scoreHome > _game.scoreAway,
      draw: _game.scoreHome == _game.scoreAway,
      goalsFor: _game.scoreHome,
      goalsAgainst: _game.scoreAway,
      isFinal: widget.match.isFinal,
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _game.isFullTime,
      child: Scaffold(
        backgroundColor: AppColors.bgDeep,
        body: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _game,
                builder: (context, _) =>
                    CustomPaint(painter: MatchPainter(_game)),
              ),
            ),
            _Hud(game: _game, match: widget.match),
            const _JoystickLayer(),
            _Buttons(
              onPass: _game.pass,
              onShoot: _game.shoot,
              onSprint: (v) => _game.setSprint(v),
            ),
            Positioned(
              top: 8,
              right: 10,
              child: _PauseButton(onPause: () => _showPause(context)),
            ),
            AnimatedBuilder(
              animation: _game,
              builder: (context, _) =>
                  _FullTimeOverlay(game: _game, match: widget.match),
            ),
          ],
        ),
      ),
    );
  }

  void _showPause(BuildContext context) {
    setState(() => _paused = true);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0B1426),
        title: const Text('Pause',
            style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w900)),
        content: const Text('Match is waiting for you.',
            style: TextStyle(color: AppColors.muted)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() => _paused = false);
            },
            child: const Text('RESUME',
                style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.w900)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('QUIT',
                style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    ).whenComplete(() {
      if (mounted && _paused) setState(() => _paused = false);
    });
  }
}

// -----------------------------------------------------------------------------
// HUD
// -----------------------------------------------------------------------------

class _Hud extends StatelessWidget {
  const _Hud({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: game,
      builder: (context, _) => Stack(
        children: [
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Center(child: _Scoreboard(game: game, match: match)),
          ),
          Positioned.fill(child: Center(child: _Banner(game: game))),
          Positioned(
            left: 12,
            bottom: 12,
            child: _Minimap(game: game),
          ),
        ],
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClubCrest(club: match.home, size: 22),
            const SizedBox(width: 8),
            Text(
              match.home.short,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '${game.scoreHome} - ${game.scoreAway}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              match.away.short,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.text,
              ),
            ),
            const SizedBox(width: 8),
            ClubCrest(club: match.away, size: 22),
            Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${game.clockMinute.toString().padLeft(2, '0')}:${game.clockSecond.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
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

class _Banner extends StatelessWidget {
  const _Banner({required this.game});

  final MatchGame game;

  @override
  Widget build(BuildContext context) {
    if (game.phase == MatchPhase.goal) {
      final userScored = game.lastScorerTeam == 0;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'GOAL!',
            style: TextStyle(
              fontSize: 54,
              height: 1,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: userScored ? AppColors.lime : AppColors.red,
              shadows: [
                Shadow(
                  color: (userScored ? AppColors.lime : AppColors.red)
                      .withValues(alpha: 0.6),
                  blurRadius: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            game.lastScorer,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
            ),
          ),
        ],
      );
    }
    if (game.phase == MatchPhase.kickoff) {
      return const Text(
        'KICK OFF',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          letterSpacing: 3,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black87, blurRadius: 12)],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _Minimap extends StatelessWidget {
  const _Minimap({required this.game});

  final MatchGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(painter: _MinimapPainter(game)),
      ),
    );
  }
}

class _MinimapPainter extends CustomPainter {
  const _MinimapPainter(this.game);

  final MatchGame game;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0F3B24),
    );
    final line = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawRect(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      line,
    );
    canvas.drawLine(
      Offset(size.width / 2, 2),
      Offset(size.width / 2, size.height - 2),
      line,
    );

    Offset map(V3 p) => Offset(
          (p.x / (MatchGame.pitchL * 2) + 0.5) * size.width,
          (p.z / (MatchGame.pitchW * 2) + 0.5) * size.height,
        );

    for (final p in game.players) {
      canvas.drawCircle(
        map(p.pos),
        p.team == 0 ? 2.4 : 2.2,
        Paint()
          ..color = p.team == 0
              ? Colors.white
              : const Color(0xFFFF4D5E).withValues(alpha: 0.95),
      );
    }
    canvas.drawCircle(
      map(game.ball),
      2.0,
      Paint()..color = AppColors.gold,
    );
  }

  @override
  bool shouldRepaint(covariant _MinimapPainter oldDelegate) => true;
}

// -----------------------------------------------------------------------------
// Joystick
// -----------------------------------------------------------------------------

class _JoystickLayer extends StatefulWidget {
  const _JoystickLayer();

  @override
  State<_JoystickLayer> createState() => _JoystickLayerState();
}

class _JoystickLayerState extends State<_JoystickLayer> {
  Offset _center = Offset.zero;
  Offset _knob = Offset.zero;
  bool _active = false;

  static const double _radius = 46;

  MatchGame get _game =>
      context.findAncestorStateOfType<_MatchScreenState>()!._game;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 0.52,
      height: MediaQuery.of(context).size.height * 0.82,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanDown: (d) {
          setState(() {
            _active = true;
            _center = d.localPosition;
            _knob = d.localPosition;
          });
        },
        onPanStart: (d) {
          setState(() {
            _active = true;
            _center = d.localPosition;
            _knob = d.localPosition;
          });
        },
        onPanUpdate: (d) {
          final delta = d.localPosition - _center;
          final dist = delta.distance;
          final clamped =
              dist > _radius ? _center + delta / dist * _radius : d.localPosition;
          setState(() => _knob = clamped);
          final v = (clamped - _center) / _radius;
          // Ekranda yuqoriga tortish maydonda +z yo'nalishi.
          _game.setJoystick(v.dx.clamp(-1.0, 1.0), (-v.dy).clamp(-1.0, 1.0));
        },
        onPanEnd: (_) => _reset(),
        onPanCancel: _reset,
        child: Stack(
          children: [
            if (_active) ...[
              Positioned(
                left: _center.dx - _radius - 16,
                top: _center.dy - _radius - 16,
                child: Container(
                  width: (_radius + 16) * 2,
                  height: (_radius + 16) * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.white.withValues(alpha: 0.02),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.28),
                      width: 1.4,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _knob.dx - 24,
                top: _knob.dy - 24,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.55),
                        Colors.white.withValues(alpha: 0.22),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 10),
                    ],
                  ),
                  child: const Icon(
                    Icons.sports_soccer_rounded,
                    size: 22,
                    color: Color(0xFF0A1120),
                  ),
                ),
              ),
            ] else
              Positioned(
                left: 24,
                bottom: 108,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.10),
                        Colors.black.withValues(alpha: 0.18),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.open_with_rounded,
                        size: 22,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'MOVE',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _reset() {
    setState(() => _active = false);
    _game.setJoystick(0, 0);
  }
}

// -----------------------------------------------------------------------------
// Tugmalar
// -----------------------------------------------------------------------------

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.onPass,
    required this.onShoot,
    required this.onSprint,
  });

  final VoidCallback onPass;
  final VoidCallback onShoot;
  final ValueChanged<bool> onSprint;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 14,
      child: SizedBox(
        width: 190,
        height: 170,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: _ActionRound(
                label: 'Shoot',
                icon: Icons.sports_soccer_rounded,
                size: 62,
                color: AppColors.red,
                onTap: onShoot,
              ),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: _ActionRound(
                label: 'Pass',
                icon: Icons.call_made_rounded,
                size: 56,
                color: AppColors.blue,
                onTap: onPass,
              ),
            ),
            Positioned(
              right: 4,
              bottom: 0,
              child: _SprintButton(
                label: 'Sprint',
                icon: Icons.bolt_rounded,
                size: 60,
                color: AppColors.lime,
                onChanged: onSprint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionRound extends StatelessWidget {
  const _ActionRound({
    required this.label,
    required this.icon,
    required this.size,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.35, -0.45),
                  radius: 1.05,
                  colors: [
                    Color.lerp(color, Colors.white, 0.35)!,
                    color.withValues(alpha: 0.30),
                  ],
                ),
                border: Border.all(color: color.withValues(alpha: 0.9), width: 1.6),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: size * 0.42,
                shadows: const [Shadow(color: Colors.black38, blurRadius: 4)],
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: 0.85),
            shadows: const [Shadow(color: Colors.black87, blurRadius: 4)],
          ),
        ),
      ],
    );
  }
}

class _SprintButton extends StatefulWidget {
  const _SprintButton({
    required this.label,
    required this.icon,
    required this.size,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final double size;
  final Color color;
  final ValueChanged<bool> onChanged;

  @override
  State<_SprintButton> createState() => _SprintButtonState();
}

class _SprintButtonState extends State<_SprintButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() => _down = true);
            widget.onChanged(true);
          },
          onTapUp: (_) {
            setState(() => _down = false);
            widget.onChanged(false);
          },
          onTapCancel: () {
            setState(() => _down = false);
            widget.onChanged(false);
          },
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: _down
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [widget.color, Color.lerp(widget.color, Colors.white, 0.3)!],
                    )
                  : RadialGradient(
                      center: const Alignment(-0.35, -0.45),
                      radius: 1.05,
                      colors: [
                        Color.lerp(widget.color, Colors.white, 0.35)!,
                        widget.color.withValues(alpha: 0.30),
                      ],
                    ),
              border: Border.all(
                color: widget.color.withValues(alpha: 0.9),
                width: 1.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: _down ? 0.55 : 0.30),
                  blurRadius: _down ? 20 : 14,
                  spreadRadius: _down ? 2 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: _down ? const Color(0xFF241A02) : Colors.white,
              size: widget.size * 0.42,
              shadows: _down
                  ? null
                  : const [Shadow(color: Colors.black38, blurRadius: 4)],
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: 0.85),
            shadows: const [Shadow(color: Colors.black87, blurRadius: 4)],
          ),
        ),
      ],
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({required this.onPause});

  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPause,
        customBorder: const CircleBorder(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: const Icon(Icons.pause_rounded, size: 18, color: Colors.white),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FULL TIME
// -----------------------------------------------------------------------------

class _FullTimeOverlay extends StatelessWidget {
  const _FullTimeOverlay({required this.game, required this.match});

  final MatchGame game;
  final MatchInfo match;

  @override
  Widget build(BuildContext context) {
    if (!game.isFullTime) return const SizedBox.shrink();
    final won = game.scoreHome > game.scoreAway;
    final draw = game.scoreHome == game.scoreAway;
    return Container(
      color: Colors.black.withValues(alpha: 0.68),
      alignment: Alignment.center,
      child: GlassPanel(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        radius: 24,
        child: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'FULL TIME',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClubCrest(club: match.home, size: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${game.scoreHome} - ${game.scoreAway}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ClubCrest(club: match.away, size: 40),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                won ? 'VICTORY!' : (draw ? 'DRAW' : 'DEFEAT'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: won ? AppColors.lime : (draw ? AppColors.gold : AppColors.red),
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RewardChip(icon: Icons.monetization_on_rounded, label: 'COINS EARNED'),
                  SizedBox(width: 10),
                  _RewardChip(icon: Icons.bolt_rounded, label: 'XP EARNED'),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Text(
                            'HOME',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardChip extends StatelessWidget {
  const _RewardChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.gold),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
