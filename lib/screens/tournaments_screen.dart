import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'match_screen.dart';

/// Turnirlar ekrani — UCL finaliga yo'l.
class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  Duration _countdown = const Duration(days: 6, hours: 12, minutes: 37);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _countdown -= const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _countdownLabel {
    final d = _countdown.inDays;
    final h = _countdown.inHours % 24;
    final m = _countdown.inMinutes % 60;
    final s = _countdown.inSeconds % 60;
    return '${d}d ${h.toString().padLeft(2, '0')}h ${m.toString().padLeft(2, '0')}m ${s.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    final match = MockData.nextMatch;
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/champions_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const _Header(title: 'Tournaments'),
                  const SizedBox(height: 14),
                  GlassPanel(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        const Icon(Icons.shield_rounded,
                            size: 34, color: AppColors.blue),
                        const SizedBox(height: 6),
                        const Text(
                          'UCL EVENT',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: AppColors.text,
                          ),
                        ),
                        const Text(
                          'CHAMPIONS LEAGUE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.5,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ClubSide(club: match.home),
                            const Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: AppColors.muted,
                              ),
                            ),
                            _ClubSide(club: match.away),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'THE FINAL · ${match.dateLabel} · ${match.timeLabel}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.timer_rounded,
                                size: 14, color: AppColors.gold),
                            const SizedBox(width: 6),
                            Text(
                              _countdownLabel,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Material(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () => pushScreen(
                              context,
                              const MatchScreen(match: MockData.nextMatch),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Text(
                                'PLAY FINAL NOW',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF241A02),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassPanel(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle('Road to the final'),
                        const SizedBox(height: 10),
                        _Round(label: 'Quarter-final', score: '3 - 1', done: true),
                        _Round(label: 'Semi-final', score: '2 - 0', done: true),
                        _Round(
                          label: 'FINAL',
                          score: state.uclChampion ? 'WON' : 'vs ${match.away.short}',
                          done: state.uclChampion,
                          highlight: !state.uclChampion,
                        ),
                      ],
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

class _ClubSide extends StatelessWidget {
  const _ClubSide({required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClubCrest(club: club, size: 56),
        const SizedBox(height: 6),
        Text(
          club.name,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _Round extends StatelessWidget {
  const _Round({
    required this.label,
    required this.score,
    required this.done,
    this.highlight = false,
  });

  final String label;
  final String score;
  final bool done;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.gold.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight
              ? AppColors.gold.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 16,
            color: done ? AppColors.lime : AppColors.muted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: highlight ? FontWeight.w900 : FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              color: done ? AppColors.lime : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: const Icon(Icons.arrow_back_rounded,
                size: 17, color: AppColors.text),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}
