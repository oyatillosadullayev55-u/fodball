import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Formatssiyalar: pozitsiya -> maydondagi joylashuv.
const formations = <String, Map<String, Alignment>>{
  '4-3-3': {
    'GK': Alignment(0, 0.94),
    'LB': Alignment(-0.78, 0.6),
    'CB': Alignment(-0.26, 0.68),
    'RB': Alignment(0.78, 0.6),
    'CM': Alignment(-0.55, 0.16),
    'LW': Alignment(-0.78, -0.62),
    'ST': Alignment(0, -0.8),
    'RW': Alignment(0.78, -0.62),
  },
  '4-4-2': {
    'GK': Alignment(0, 0.94),
    'LB': Alignment(-0.78, 0.6),
    'CB': Alignment(-0.28, 0.68),
    'RB': Alignment(0.78, 0.6),
    'LM': Alignment(-0.8, 0.05),
    'CM': Alignment(-0.27, 0.18),
    'RM': Alignment(0.8, 0.05),
    'ST': Alignment(-0.2, -0.75),
  },
  '3-5-2': {
    'GK': Alignment(0, 0.94),
    'CB': Alignment(-0.5, 0.68),
    'LM': Alignment(-0.82, 0.05),
    'CM': Alignment(-0.42, 0.15),
    'RM': Alignment(0.82, 0.05),
    'ST': Alignment(-0.2, -0.75),
  },
};

/// "My Team" ekrani — eFootball uslubida tarkib boshqaruvi.
class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  int _tab = 0;
  String _formation = '4-3-3';
  Player? _swapSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formation = _detectFormation(GameStateScope.of(context).squad);
  }

  String _detectFormation(List<Player> squad) {
    final lbs = squad.where((p) => p.isStarter && p.position == 'LB').length;
    final cms = squad.where((p) => p.isStarter && p.position == 'CM').length;
    if (lbs == 0) return '3-5-2';
    if (cms <= 2) return '4-4-2';
    return '4-3-3';
  }

  void _applyFormation(GameState state, String formation) {
    final spots = formations[formation]!;
    final starters = state.squad.where((p) => p.isStarter).toList();
    final used = <Player>{};

    Alignment spotFor(Player p) {
      final direct = spots[p.position];
      if (direct != null) return direct;
      // Qo'shnilik pozitsiyalar: CB <-> anything defense etc.
      for (final pos in _related(p.position)) {
        if (spots.containsKey(pos)) return spots[pos]!;
      }
      return p.alignment;
    }

    final taken = <Alignment>{};
    for (final p in starters) {
      var spot = spotFor(p);
      var guard = 0;
      while (taken.contains(spot) && guard < 8) {
        spot = Alignment(spot.x + 0.16, spot.y);
        guard++;
      }
      taken.add(spot);
      used.add(p);
      final i = state.squad.indexOf(p);
      state.squad[i] = p.copyWith(alignment: spot);
    }
    setState(() => _formation = formation);
    state.refresh();
  }

  List<String> _related(String pos) => switch (pos) {
        'CB' => ['CB'],
        'RB' || 'LB' => ['RB', 'LB'],
        'CM' || 'CDM' || 'CAM' => ['CM'],
        'LM' || 'RM' => ['LM', 'RM', 'CM'],
        'LW' => ['LW', 'LM'],
        'RW' => ['RW', 'RM'],
        'ST' => ['ST'],
        _ => const [],
      };

  void _autoLineup(GameState state) {
    final all = [...state.squad, ...state.reserves]
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final spots = formations[_formation]!;
    final spotKeys = <String>[];
    // GK birinchi.
    spotKeys.add('GK');
    spotKeys.addAll(spots.keys.where((k) => k != 'GK'));

    final newStarters = <Player>[];
    final rest = <Player>[];
    for (final p in all) {
      if (newStarters.length < 11) {
        newStarters.add(p);
      } else {
        rest.add(p);
      }
    }
    // GK ni eng yaxshi GK ga qo'yish.
    newStarters.sort((a, b) {
      final aGk = a.position == 'GK' ? 0 : 1;
      final bGk = b.position == 'GK' ? 0 : 1;
      return aGk != bGk ? aGk.compareTo(bGk) : 0;
    });

    final taken = <Alignment>{};
    final assigned = <Player>[];
    for (var i = 0; i < newStarters.length; i++) {
      final p = newStarters[i];
      final key = i < spotKeys.length ? spotKeys[i] : 'ST';
      var spot = spots[key]!;
      var guard = 0;
      while (taken.contains(spot) && guard < 8) {
        spot = Alignment(spot.x + 0.16, spot.y);
        guard++;
      }
      taken.add(spot);
      assigned.add(p.copyWith(position: key, alignment: spot));
    }
    state.squad
      ..clear()
      ..addAll(assigned);
    state.reserves
      ..clear()
      ..addAll(rest.map((p) => p.copyWith(alignment: Alignment.center)));
    state.refresh();
    setState(() => _swapSource = null);
  }

  void _onPlayerTap(GameState state, Player player, bool starter) {
    if (_swapSource == null) {
      setState(() => _swapSource = player);
      return;
    }
    final a = _swapSource!;
    if (a == player) {
      setState(() => _swapSource = null);
      return;
    }
    final aStarter = state.squad.contains(a);
    final bStarter = starter;
    if (aStarter && bStarter) {
      final i = state.squad.indexOf(a);
      final j = state.squad.indexOf(player);
      final tmp = state.squad[i].alignment;
      state.squad[i] = state.squad[i].copyWith(alignment: state.squad[j].alignment);
      state.squad[j] = state.squad[j].copyWith(alignment: tmp);
    } else if (aStarter != bStarter) {
      final starterP = aStarter ? a : player;
      final reserveP = aStarter ? player : a;
      final i = state.squad.indexOf(starterP);
      final j = state.reserves.indexOf(reserveP);
      final spot = state.squad[i].alignment;
      final pos = state.squad[i].position;
      state.squad[i] = reserveP.copyWith(alignment: spot, position: pos);
      state.reserves[j] = starterP.copyWith(alignment: Alignment.center);
    }
    state.refresh();
    setState(() => _swapSource = null);
  }

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    final wide = MediaQuery.of(context).size.width >= 760;
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => Column(
                children: [
                  _Header(tab: _tab, onTab: (i) => setState(() => _tab = i)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                      child: switch (_tab) {
                        0 => wide
                            ? Row(
                                children: [
                                  Expanded(child: _PitchView(state: state, swapSource: _swapSource, onPlayerTap: (p, s) => _onPlayerTap(state, p, s))),
                                  const SizedBox(width: 12),
                                  SizedBox(width: 280, child: _TeamPanel(state: state, formation: _formation, onAutoLineup: () => _autoLineup(state))),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 420, child: _PitchView(state: state, swapSource: _swapSource, onPlayerTap: (p, s) => _onPlayerTap(state, p, s))),
                                    const SizedBox(height: 12),
                                    SizedBox(height: 430, child: _TeamPanel(state: state, formation: _formation, onAutoLineup: () => _autoLineup(state))),
                                  ],
                                ),
                              ),
                        1 => _PlayersTab(
                              state: state,
                              swapSource: _swapSource,
                              onPlayerTap: (p, s) => _onPlayerTap(state, p, s),
                            ),
                        2 => _UpgradesTab(state: state),
                        _ => _TacticsTab(
                              formation: _formation,
                              onChanged: (f) => _applyFormation(state, f),
                            ),
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

// -----------------------------------------------------------------------------
// Sarlavha va tablar
// -----------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header({required this.tab, required this.onTab});

  final int tab;
  final ValueChanged<int> onTab;

  static const _tabs = ['My Team', 'Players', 'Upgrades', 'Tactics'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 12, 6),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  size: 17, color: AppColors.text),
            ),
          ),
          const SizedBox(width: 10),
          ...List.generate(_tabs.length, (i) {
            final active = i == tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: active ? AppColors.blue : Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: () => onTab(i),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: active
                            ? Colors.transparent
                            : Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: active ? Colors.white : AppColors.muted,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Maydon ko'rinishi
// -----------------------------------------------------------------------------

class _PitchView extends StatelessWidget {
  const _PitchView({
    required this.state,
    required this.swapSource,
    required this.onPlayerTap,
  });

  final GameState state;
  final Player? swapSource;
  final void Function(Player player, bool starter) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    final starters = state.squad;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 20),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(painter: _PitchPainter()),
            for (final p in starters)
              Align(
                alignment: p.alignment,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () => onPlayerTap(p, true),
                    child: PlayerCard(
                      player: p,
                      width: 74,
                      selected: swapSource == p,
                    ),
                  ),
                ),
              ),
            if (swapSource != null)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Swap: choose another player',
                      style: TextStyle(fontSize: 10.5, color: AppColors.lime),
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

class _PitchPainter extends CustomPainter {
  const _PitchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stripeCount = 8;
    for (var i = 0; i < stripeCount; i++) {
      final stripe = Rect.fromLTWH(
        rect.left,
        rect.top + rect.height / stripeCount * i,
        rect.width,
        rect.height / stripeCount + 1,
      );
      canvas.drawRect(
        stripe,
        Paint()..color = i.isEven ? AppColors.pitch : AppColors.pitchAlt,
      );
    }
    // Vignette.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.35)],
        ).createShader(rect),
    );

    final line = Paint()
      ..color = AppColors.pitchLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final w = size.width, h = size.height;
    // Chegaralar.
    canvas.drawRect(Rect.fromLTRB(w * 0.03, h * 0.03, w * 0.97, h * 0.97), line);
    // O'rta chiziq va doira.
    canvas.drawLine(Offset(w * 0.03, h / 2), Offset(w * 0.97, h / 2), line);
    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.11, line);
    // Jarima maydonlari.
    canvas.drawRect(Rect.fromLTRB(w * 0.22, h * 0.03, w * 0.78, h * 0.17), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.34, h * 0.03, w * 0.66, h * 0.09), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.22, h * 0.83, w * 0.78, h * 0.97), line);
    canvas.drawRect(Rect.fromLTRB(w * 0.34, h * 0.91, w * 0.66, h * 0.97), line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// Jamoa paneli (o'ng)
// -----------------------------------------------------------------------------

class _TeamPanel extends StatelessWidget {
  const _TeamPanel({
    required this.state,
    required this.formation,
    required this.onAutoLineup,
  });

  final GameState state;
  final String formation;
  final VoidCallback onAutoLineup;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tight = constraints.maxHeight < 400;
          final content = <Widget>[
            const Text(
              'Team Power',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.muted),
            ),
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  state.teamPower,
                  style: const TextStyle(
                    fontSize: 38,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final s in MockData.teamStats)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _StatLine(label: s.label, value: s.value),
              ),
            if (!tight) const Spacer() else const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Formation',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.text),
                ),
                const Spacer(),
                Text(
                  formation,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.lime),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 74,
              child: CustomPaint(painter: _FormationPainter(formation)),
            ),
            const SizedBox(height: 12),
            Material(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onAutoLineup,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white),
                      SizedBox(width: 7),
                      Text(
                        'Auto Lineup',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
          final column = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: tight ? MainAxisSize.min : MainAxisSize.max,
            children: content,
          );
          return tight ? SingleChildScrollView(child: column) : column;
        },
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  const _StatLine({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74,
          child: Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: AppColors.text),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation(AppColors.lime),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 26,
          child: Text(
            '${(value * 100).round()}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: AppColors.text),
          ),
        ),
      ],
    );
  }
}

class _FormationPainter extends CustomPainter {
  const _FormationPainter(this.formation);

  final String formation;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(r, Paint()..color = AppColors.pitch);
    final line = Paint()
      ..color = AppColors.pitchLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(r, line);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), line);

    final spots = formations[formation]!;
    final taken = <Offset>{};
    final dot = Paint();
    for (final entry in spots.entries) {
      var o = Offset(
        size.width / 2 + entry.value.x * size.width * 0.42,
        size.height / 2 + entry.value.y * size.height * 0.42,
      );
      var guard = 0;
      while (taken.any((t) => (t - o).distance < 5) && guard < 6) {
        o = Offset(o.dx + 6, o.dy);
        guard++;
      }
      taken.add(o);
      dot.color = entry.key == 'GK' ? AppColors.gold : AppColors.blue;
      canvas.drawCircle(o, 4, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _FormationPainter oldDelegate) =>
      oldDelegate.formation != formation;
}

// -----------------------------------------------------------------------------
// Players tabi (almashtirish ro'yxati)
// -----------------------------------------------------------------------------

class _PlayersTab extends StatelessWidget {
  const _PlayersTab({
    required this.state,
    required this.swapSource,
    required this.onPlayerTap,
  });

  final GameState state;
  final Player? swapSource;
  final void Function(Player player, bool starter) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SectionTitle('Starting XI'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in state.squad)
              GestureDetector(
                onTap: () => onPlayerTap(p, true),
                child: PlayerCard(
                  player: p,
                  width: 86,
                  selected: swapSource == p,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        SectionTitle('Reserves (${state.reserves.length})'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in state.reserves)
              GestureDetector(
                onTap: () => onPlayerTap(p, false),
                child: PlayerCard(
                  player: p,
                  width: 86,
                  selected: swapSource == p,
                ),
              ),
            if (state.packPlayers.isNotEmpty) ...[
              for (final p in state.packPlayers)
                GestureDetector(
                  onTap: () => _promote(context, p),
                  child: PlayerCard(player: p, width: 86),
                ),
            ],
          ],
        ),
        if (state.packPlayers.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'Tap a new player to move him into reserves',
            style: TextStyle(fontSize: 10.5, color: AppColors.muted),
          ),
        ],
      ],
    );
  }

  void _promote(BuildContext context, Player p) {
    final state = GameStateScope.of(context);
    state.packPlayers.remove(p);
    state.reserves.add(p);
    state.refresh();
  }
}

// -----------------------------------------------------------------------------
// Upgrades tabi
// -----------------------------------------------------------------------------

class _UpgradesTab extends StatelessWidget {
  const _UpgradesTab({required this.state});

  final GameState state;

  int _cost(Player p) => (p.rating - 84) * 40000;

  @override
  Widget build(BuildContext context) {
    final all = [...state.squad, ...state.reserves, ...state.packPlayers];
    return ListView.separated(
      itemCount: all.length,
      separatorBuilder: (context, i) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = all[i];
        final cost = _cost(p);
        final maxed = p.rating >= 99;
        return GlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          radius: 12,
          child: Row(
            children: [
              PlayerCard(player: p, width: 46, showName: false),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      '${p.position} · OVR ${p.rating}',
                      style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              if (maxed)
                const Text(
                  'MAX',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.gold,
                  ),
                )
              else
                Material(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      if (state.spendCoins(cost)) {
                        _upgrade(p);
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_upward_rounded,
                              size: 13, color: Color(0xFF241A02)),
                          const SizedBox(width: 4),
                          Text(
                            '+1  ${_formatCost(cost)}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF241A02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _upgrade(Player p) {
    final i = state.squad.indexOf(p);
    if (i >= 0) {
      state.squad[i] = p.copyWith(
        rating: p.rating + 1,
        pace: p.pace + 1,
        shooting: p.shooting + 1,
        passing: p.passing + 1,
        defending: p.defending + 1,
      );
    } else {
      final j = state.reserves.indexOf(p);
      if (j >= 0) {
        state.reserves[j] = p.copyWith(
          rating: p.rating + 1,
          pace: p.pace + 1,
          shooting: p.shooting + 1,
          passing: p.passing + 1,
          defending: p.defending + 1,
        );
      } else {
        final k = state.packPlayers.indexOf(p);
        if (k >= 0) {
          state.packPlayers[k] = p.copyWith(
            rating: p.rating + 1,
            pace: p.pace + 1,
            shooting: p.shooting + 1,
            passing: p.passing + 1,
            defending: p.defending + 1,
          );
        }
      }
    }
    state.refresh();
  }

  static String _formatCost(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).round()}K';
    return '$v';
  }
}

// -----------------------------------------------------------------------------
// Tactics tabi
// -----------------------------------------------------------------------------

class _TacticsTab extends StatelessWidget {
  const _TacticsTab({required this.formation, required this.onChanged});

  final String formation;
  final ValueChanged<String> onChanged;

  static const _styles = [
    (name: 'Balanced', icon: Icons.balance_rounded),
    (name: 'Attacking', icon: Icons.local_fire_department_rounded),
    (name: 'Defensive', icon: Icons.shield_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SectionTitle('Formation'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (final f in formations.keys)
              GestureDetector(
                onTap: () => onChanged(f),
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: f == formation
                        ? AppColors.blue.withValues(alpha: 0.25)
                        : Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: f == formation
                          ? AppColors.blue
                          : Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 84,
                        child: CustomPaint(painter: _FormationPainter(f)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        f,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: f == formation ? Colors.white : AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        const SectionTitle('Team Style'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (final s in _styles)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(s.icon, size: 15, color: AppColors.lime),
                    const SizedBox(width: 6),
                    Text(
                      s.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
