import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_body_health_calculator_project/views/home_ui.dart';
import 'package:flutter_body_health_calculator_project/views/splash_screen_ui.dart';

void main() {
  setUpAll(() async {
    final font = FontLoader('Kanit')
      ..addFont(rootBundle.load('assets/fonts/Kanit-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Kanit-Bold.ttf'));
    await font.load();
    await (FontLoader('MaterialIcons')
          ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf')))
        .load();
  });
  testWidgets('calculate reset and switch tabs at phone viewport',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final theme = ThemeData(
        fontFamily: 'Kanit',
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)));
    await tester.pumpWidget(MaterialApp(
        theme: theme,
        home: const RepaintBoundary(
            key: ValueKey('screen'), child: SplashScreenUI())));
    await tester.runAsync(() async {
      final context = tester.element(find.byKey(const ValueKey('screen')));
      for (final file in [
        'bmi.png',
        'bmr.png',
        'calculate.png',
        'saulogo.png'
      ]) {
        await precacheImage(AssetImage('assets/images/$file'), context);
      }
    });
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(find.byKey(const ValueKey('screen')),
        matchesGoldenFile('previews/splash.png'));
    await tester.pumpWidget(MaterialApp(
        theme: theme,
        home: const RepaintBoundary(key: ValueKey('home'), child: HomeUI())));
    await tester.pumpAndSettle();
    await expectLater(find.byKey(const ValueKey('home')),
        matchesGoldenFile('previews/about.png'));
    await tester.tap(find.text('BMI').last);
    await tester.pumpAndSettle();
    await expectLater(find.byKey(const ValueKey('home')),
        matchesGoldenFile('previews/bmi.png'));
    await tester.enterText(find.byType(TextFormField).at(0), '70');
    await tester.enterText(find.byType(TextFormField).at(1), '175');
    await tester.tap(find.text('คำนวณ BMI'));
    await tester.pumpAndSettle();
    expect(find.text('22.86'), findsOneWidget);
    await tester.tap(find.text('ล้างข้อมูล'));
    await tester.pumpAndSettle();
    expect(find.text('0.00'), findsOneWidget);
    await tester.tap(find.text('BMR').last);
    await tester.pumpAndSettle();
    await expectLater(find.byKey(const ValueKey('home')),
        matchesGoldenFile('previews/bmr.png'));
    await tester.enterText(find.byType(TextFormField).at(0), '70');
    await tester.enterText(find.byType(TextFormField).at(1), '175');
    await tester.enterText(find.byType(TextFormField).at(2), '30.0');
    await tester.ensureVisible(find.text('คำนวณ BMR'));
    await tester.tap(find.text('คำนวณ BMR'));
    await tester.pumpAndSettle();
    expect(find.text('1695.67'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
