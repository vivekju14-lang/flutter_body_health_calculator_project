import 'package:flutter/material.dart';
import '../models/health_calculator.dart';
import '../widgets/calculator_widgets.dart';

class BmrUI extends StatefulWidget {
  const BmrUI({super.key});
  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  final weight = TextEditingController(),
      height = TextEditingController(),
      age = TextEditingController();
  final form = GlobalKey<FormState>();
  BiologicalSex sex = BiologicalSex.male;
  double? result;
  @override
  void dispose() {
    weight.dispose();
    height.dispose();
    age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: form,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                        'คำนวณหาอัตราการเผาผลาญที่\nร่างกายต้องการ (BMR)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17)),
                    const SizedBox(height: 16),
                    Image.asset('assets/images/bmr.png', height: 110),
                    const SizedBox(height: 12),
                    const Text('เพศ', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(children: [
                      for (final s in BiologicalSex.values)
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: sex == s
                                            ? const Color(0xFFBBDEFB)
                                            : Colors.white,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    onPressed: () => setState(() {
                                          sex = s;
                                          result = null;
                                        }),
                                    child: Text(s == BiologicalSex.male
                                        ? 'ชาย'
                                        : 'หญิง'))))
                    ]),
                    const SizedBox(height: 18),
                    NumberInput(
                        label: 'น้ำหนัก (kg.)',
                        hint: 'กรอกน้ำหนักของคุณ',
                        controller: weight),
                    NumberInput(
                        label: 'ส่วนสูง (cm.)',
                        hint: 'กรอกส่วนสูงของคุณ',
                        controller: height),
                    NumberInput(
                        label: 'อายุ (ปี)',
                        hint: 'กรอกอายุของคุณ',
                        controller: age,
                        integer: true),
                    ActionButton(
                        label: 'คำนวณ BMR',
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            try {
                              final value = HealthCalculator.bmr(
                                  weightKg: double.parse(weight.text.trim()),
                                  heightCm: double.parse(height.text.trim()),
                                  ageYears:
                                      double.parse(age.text.trim()).round(),
                                  sex: sex);
                              FocusScope.of(context).unfocus();
                              setState(() => result = value);
                            } on ArgumentError {
                              invalidResult(context);
                            }
                          }
                        }),
                    ActionButton(
                        label: 'ล้างข้อมูล',
                        reset: true,
                        onPressed: () {
                          form.currentState!.reset();
                          weight.clear();
                          height.clear();
                          age.clear();
                          setState(() {
                            result = null;
                            sex = BiologicalSex.male;
                          });
                        }),
                    const SizedBox(height: 8),
                    ResultPanel(value: result, detail: 'kcal/day'),
                  ]))));
}
