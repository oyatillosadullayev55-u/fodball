import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/game_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const FodballApp());
}

class FodballApp extends StatelessWidget {
  const FodballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fodball 3D',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const GameScreen(),
    );
  }
}
