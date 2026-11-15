import 'package:flutter/material.dart';

import '../state/game_state.dart';
import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Karyera ekrani — statistika va mavsum progressi.
class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero_player.png',
            fit: BoxFit.cover,
            alignment: const Alignment(0.5, -0.2),
            color: Colors.black.withValues(alpha: 0.55),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const _ScreenHeader(title: 'Player Career'),
                  const SizedBox(height: 14),
                  GlassPanel(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.userHandle,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Level ${state.level} · ${state.userClub.name} Manager',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: state.xp / state.xpMax,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.08),
                            valueColor:
                                const AlwaysStoppedAnimation(AppColors.blue),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'XP ${state.xp} / ${state.xpMax}',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StatTile(label: 'Matches', value: '${state.careerMatches}', icon: Icons.sports_soccer_rounded, color: AppColors.blue),
                      _StatTile(label: 'Wins', value: '${state.careerWins}', icon: Icons.check_circle_rounded, color: AppColors.lime),
                      _StatTile(label: 'Goals', value: '${state.careerGoals}', icon: Icons.sports_soccer_rounded, color: AppColors.gold),
                      _StatTile(label: 'Assists', value: '${state.careerAssists}', icon: Icons.handshake_rounded, color: AppColors.violet),
                      _StatTile(label: 'Trophies', value: '${state.trophies}', icon: Icons.emoji_events_rounded, color: AppColors.red),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GlassPanel(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle('Season Objective'),
                        const SizedBox(height: 10),
                        const Text(
                          'Win the Champions League final',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: state.uclChampion ? 1 : 0.85,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.08),
                            valueColor: AlwaysStoppedAnimation(
                              state.uclChampion ? AppColors.lime : AppColors.gold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.uclChampion ? 'COMPLETED' : '85% — final waiting',
                          style: const TextStyle(
                            fontSize: 10.5,
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
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: GlassPanel(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 19, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Umumiy ekran sarlavhasi (orqaga tugma + sarlavha).
class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader({required this.title});

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
