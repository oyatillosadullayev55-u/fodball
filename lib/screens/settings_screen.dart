import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/ui.dart';

/// Sozlamalar ekrani.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sound = true;
  bool _haptics = true;
  bool _notifications = true;
  double _matchLength = 150;

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
            color: Colors.black.withValues(alpha: 0.62),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: ListView(
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
                      'Settings',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GlassPanel(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      _SwitchTile(
                        title: 'Sound',
                        subtitle: 'Crowd and stadium effects',
                        icon: Icons.volume_up_rounded,
                        value: _sound,
                        onChanged: (v) => setState(() => _sound = v),
                      ),
                      _Divider(),
                      _SwitchTile(
                        title: 'Haptics',
                        subtitle: 'Vibration on goals and shots',
                        icon: Icons.vibration_rounded,
                        value: _haptics,
                        onChanged: (v) => setState(() => _haptics = v),
                      ),
                      _Divider(),
                      _SwitchTile(
                        title: 'Notifications',
                        subtitle: 'Match and reward reminders',
                        icon: Icons.notifications_rounded,
                        value: _notifications,
                        onChanged: (v) => setState(() => _notifications = v),
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
                      const Text(
                        'Match length',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      Slider(
                        value: _matchLength,
                        min: 60,
                        max: 300,
                        divisions: 4,
                                    label: '${_matchLength.round()}s',
                        onChanged: (v) => setState(() => _matchLength = v),
                      ),
                      Text(
                        'A match lasts about ${_matchLength.round()} seconds of real time',
                        style:
                            const TextStyle(fontSize: 11, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GlassPanel(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Fodball 3D · Football Legends\n'
                        'Built with Flutter — own 3D engine, no external packages.\n'
                        'Version 2.0.0',
                        style: TextStyle(fontSize: 11.5, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.white.withValues(alpha: 0.07),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.lime),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
