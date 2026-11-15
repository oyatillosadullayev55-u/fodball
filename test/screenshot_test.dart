import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fodball/data/mock_data.dart';
import 'package:fodball/screens/home_screen.dart';
import 'package:fodball/screens/match_screen.dart';
import 'package:fodball/screens/store_screen.dart';
import 'package:fodball/screens/team_screen.dart';
import 'package:fodball/state/game_state.dart';
import 'package:fodball/theme/app_theme.dart';

Future<void> _loadRealFonts() async {
  final sdk = Platform.environment['FLUTTER_ROOT'] ??
      r'C:\Users\user\Downloads\flutter_windows_3.47.5-stable\flutter';
  final iconFont = File(
      '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
  if (iconFont.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(iconFont.readAsBytesSync())));
    await loader.load();
  }
  final roboto = File(r'C:\Windows\Fonts\segoeui.ttf');
  if (roboto.existsSync()) {
    final loader = FontLoader('Roboto')
      ..addFont(Future.value(ByteData.sublistView(roboto.readAsBytesSync())));
    final bold = File(r'C:\Windows\Fonts\segoeuib.ttf');
    if (bold.existsSync()) {
      loader.addFont(
          Future.value(ByteData.sublistView(bold.readAsBytesSync())));
    }
    await loader.load();
  }
}

Future<void> _pump(WidgetTester tester, Size size, Widget screen,
    {bool settle = true}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final theme = AppTheme.dark;
  await tester.pumpWidget(
    RepaintBoundary(
      key: const ValueKey('shot'),
      child: GameStateScope(
        state: GameState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
            textTheme: theme.textTheme.apply(fontFamily: 'Roboto'),
          ),
          home: screen,
        ),
      ),
    ),
  );
  if (settle) {
    // Widget testlarida rasm dekodlash real (fake bo'lmagan) vaqt talab
    // qiladi, shuning uchun ularni runAsync ichida oldindan yuklaymiz.
    await tester.runAsync(() async {
      final context = tester.element(find.byType(MaterialApp));
      for (final asset in const [
        'assets/images/hero_player.png',
        'assets/images/stadium_bg.png',
        'assets/images/champions_bg.png',
      ]) {
        await precacheImage(AssetImage(asset), context);
      }
    });
    await tester.pumpAndSettle();
  } else {
    for (var i = 0; i < 180; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
  }
}

void main() {
  setUpAll(_loadRealFonts);

  testWidgets('shot: home portrait', (tester) async {
    await _pump(tester, const Size(360, 806), const HomeScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_home_portrait.png'));
  });

  testWidgets('shot: home landscape', (tester) async {
    await _pump(tester, const Size(806, 360), const HomeScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_home_landscape.png'));
  });

  testWidgets('shot: team', (tester) async {
    await _pump(tester, const Size(806, 360), const TeamScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_team.png'));
  });

  testWidgets('shot: match', (tester) async {
    await _pump(tester, const Size(806, 360),
        const MatchScreen(match: MockData.nextMatch),
        settle: false);
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_match.png'));
  });

  testWidgets('shot: store', (tester) async {
    await _pump(tester, const Size(360, 806), const StoreScreen());
    await expectLater(find.byKey(const ValueKey('shot')),
        matchesGoldenFile('docs/verify_store.png'));
  });
}
