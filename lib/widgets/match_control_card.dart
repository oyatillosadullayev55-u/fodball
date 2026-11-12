import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'common.dart';

/// O'yin boshqaruvi: hisob va Shoot / Pass / Sprint.
class MatchControlCard extends StatelessWidget {
  const MatchControlCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Match control',
            trailing: Pill(
              text: '2ND HALF',
              color: Color(0x33FF4D5E),
              textColor: AppColors.red,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Call the next move — timing wins matches.',
            style: TextStyle(fontSize: 11.5, color: AppColors.muted),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _ActionButton(
                  label: 'Shoot',
                  icon: Icons.sports_soccer_rounded,
                  color: AppColors.lime,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: 'Pass',
                  icon: Icons.swap_horiz_rounded,
                  color: AppColors.blue,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: 'Sprint',
                  icon: Icons.bolt_rounded,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _MatchStat(value: '58%', label: 'Possession'),
              _MatchStat(value: '7', label: 'Shots'),
              _MatchStat(value: '1.84', label: 'xG'),
              _MatchStat(value: '89%', label: 'Passes'),
            ],
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
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchStat extends StatelessWidget {
  const _MatchStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9.5, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
