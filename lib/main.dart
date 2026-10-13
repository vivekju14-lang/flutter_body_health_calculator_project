import 'package:flutter/material.dart';
import 'views/splash_screen_ui.dart';

void main() => runApp(const BodyApp());
const accent = Color(0xFFFF5722);
const pageColor = Color(0xFFFFF7FF);

class BodyApp extends StatelessWidget {
  const BodyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Body ร่าง',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Kanit',
          scaffoldBackgroundColor: pageColor,
          colorScheme: ColorScheme.fromSeed(seedColor: accent)),
      home: const SplashScreenUI());
}
