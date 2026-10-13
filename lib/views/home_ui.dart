import 'package:flutter/material.dart';
import 'bmi_ui.dart';
import 'bmr_ui.dart';
import 'about_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int index = 1;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('Body Health Calculator',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color(0xFFD93400)),
      body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: IndexedStack(
                  index: index,
                  children: const [BmiUI(), AboutUI(), BmrUI()]))),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          selectedItemColor: const Color(0xFFFF5722),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'BMI'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'About'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMR')
          ]));
}
