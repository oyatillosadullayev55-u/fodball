import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'state/game_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(FodballApp(state: GameState()));
}

class FodballApp extends StatelessWidget {
  const FodballApp({super.key, required this.state, this.home});

  final GameState state;
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return GameStateScope(
      state: state,
      child: MaterialApp(
        title: 'Fodball 3D — Football Legends',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: home ?? const HomeScreen(),
      ),
    );
  }
}
