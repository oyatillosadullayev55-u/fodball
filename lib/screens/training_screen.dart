import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/ui.dart';
import 'game_screen.dart';

/// Mashg'ulot ekrani — penalti rejimiga kirish.
class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/stadium_bg.png',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.5),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GlassPanel(
                  padding: const EdgeInsets.all(22),
                  child: SizedBox(
                    width: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 34,
                                height: 34,
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
                            const SizedBox(width: 10),
                            const Text(
                              'Training',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Icon(Icons.sports_rounded,
                            size: 44, color: AppColors.lime),
                        const SizedBox(height: 8),
                        const Text(
                          'Penalty Practice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Sharpen your finishing in the 3D arena. 10 shots, '
                          'the keeper reads you better every time — aim for the corners!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: AppColors.muted),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Reward: up to 50,000 coins per session',
                          style: TextStyle(fontSize: 11.5, color: AppColors.gold),
                        ),
                        const SizedBox(height: 16),
                        Material(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(999),
                          child: InkWell(
                            onTap: () => pushScreen(context, const GameScreen()),
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Text(
                                'START TRAINING',
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
