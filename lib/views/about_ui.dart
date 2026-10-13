import 'package:flutter/material.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, size) => SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.maxHeight),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: Column(children: [
                    SizedBox(height: size.maxHeight * 0.20),
                    const Text('Body Health Calculator',
                        style: TextStyle(
                            color: Color(0xFFFF5722),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Image.asset('assets/images/calculate.png',
                        width: 120, height: 120),
                    const SizedBox(height: 24),
                    const Text(
                        'คำนวณหาค่าดัชนีมวลกาย (BMI)\nคำนวณหาพลังงานที่ร่างกายต้องการ (BMR)',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xFFFF5722), fontSize: 16)),
                    const SizedBox(height: 26),
                    const Text('Rajesh Kumar Upadhayay\n6819110001',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13)),
                    const SizedBox(height: 60),
                    Image.asset('assets/images/saulogo.png', height: 52),
                    const SizedBox(height: 10),
                    const Text(
                        '© 2026 SAU. All rights reserved\nCreated by SAU Software Development Team',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ])))));
}
