import 'package:flutter/material.dart';

import '../state/game_state.dart';
import '../theme/app_colors.dart';

/// Yutuqlar ekrani — missiyalar va sovg'alar.
class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GameStateScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/champions_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.62),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: state,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: const Icon(Icons.arrow_back_rounded,
                              size: 17, color: AppColors.text),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Achievements',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (final a in state.achievements)
                    _AchievementRow(
                      title: a.title,
                      description: a.description,
                      progress: a.progress,
                      target: a.target,
                      reward: a.rewardCoins,
                      complete: a.isComplete,
                      claimed: a.claimed,
                      onClaim: a.isComplete && !a.claimed
                          ? () {
                              state.claimAchievement(a.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '+${_format(a.rewardCoins)} coins claimed!',
                                  ),
                                ),
                              );
                            }
                          : null,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _format(int v) {
    if (v >= 1000) return '${(v / 1000).round()}K';
    return '$v';
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.reward,
    required this.complete,
    required this.claimed,
    required this.onClaim,
  });

  final String title;
  final String description;
  final int progress;
  final int target;
  final int reward;
  final bool complete;
  final bool claimed;
  final VoidCallback? onClaim;

  @override
  Widget build(BuildContext context) {
    final ratio = (progress / target).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF16233F).withValues(alpha: 0.8),
            const Color(0xFF0A1120).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: complete
              ? AppColors.lime.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.09),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: (complete ? AppColors.gold : AppColors.blue)
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              complete ? Icons.emoji_events_rounded : Icons.flag_rounded,
              size: 20,
              color: complete ? AppColors.gold : AppColors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: ratio,
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          valueColor: AlwaysStoppedAnimation(
                            complete ? AppColors.lime : AppColors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$progress/$target',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                '+${reward >= 1000 ? '${(reward / 1000).round()}K' : reward}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 5),
              if (claimed)
                const Icon(Icons.check_circle_rounded,
                    size: 20, color: AppColors.lime)
              else
                Material(
                  color: onClaim != null
                      ? AppColors.lime
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: onClaim,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        'CLAIM',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          color: onClaim != null
                              ? const Color(0xFF241A02)
                              : AppColors.muted,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
