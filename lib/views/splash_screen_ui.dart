import 'dart:async';
import 'package:flutter/material.dart';
import 'home_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});
  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute<void>(builder: (_) => const HomeUI()));
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFFD93400),
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset('assets/images/calculate.png', width: 210, height: 210),
        const SizedBox(height: 35),
        const Text('Body Health Calculator',
            style: TextStyle(color: Colors.white, fontSize: 19)),
        const SizedBox(height: 35),
        const CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
      ])));
}
