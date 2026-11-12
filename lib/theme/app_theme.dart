import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.lime,
        onPrimary: AppColors.bgDeep,
        secondary: AppColors.gold,
        onSecondary: AppColors.bgDeep,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        error: AppColors.red,
      ),
      textTheme: base.textTheme
          .apply(
            bodyColor: AppColors.text,
            displayColor: AppColors.text,
          )
          .copyWith(
            displayLarge: const TextStyle(
              fontSize: 44,
              height: 0.95,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              color: AppColors.text,
            ),
            headlineMedium: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: AppColors.text,
            ),
            titleMedium: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
            bodyMedium: const TextStyle(
              fontSize: 13,
              height: 1.35,
              color: AppColors.text,
            ),
            bodySmall: const TextStyle(
              fontSize: 11.5,
              height: 1.3,
              color: AppColors.muted,
            ),
            labelSmall: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: AppColors.muted,
            ),
          ),
      dividerColor: AppColors.stroke,
      splashColor: AppColors.lime.withValues(alpha: 0.06),
      highlightColor: Colors.transparent,
    );
  }
}
