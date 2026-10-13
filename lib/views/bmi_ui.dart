import 'package:flutter/material.dart';
import '../models/health_calculator.dart';
import '../widgets/calculator_widgets.dart';

class BmiUI extends StatefulWidget {
  const BmiUI({super.key});
  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final weight = TextEditingController(), height = TextEditingController();
  final form = GlobalKey<FormState>();
  double? result;
  @override
  void dispose() {
    weight.dispose();
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
              key: form,
              child: Column(children: [
                const Text('คำนวณหาค่าดัชนีมวลกาย (BMI)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17)),
                const SizedBox(height: 18),
                Image.asset('assets/images/bmi.png', height: 140),
                const SizedBox(height: 24),
                NumberInput(
                    label: 'น้ำหนัก (kg.)',
                    hint: 'กรอกน้ำหนักของคุณ',
                    controller: weight),
                NumberInput(
                    label: 'ส่วนสูง (cm.)',
                    hint: 'กรอกส่วนสูงของคุณ',
                    controller: height),
                ActionButton(
                    label: 'คำนวณ BMI',
                    onPressed: () {
                      if (form.currentState!.validate()) {
                        try {
                          final value = HealthCalculator.bmi(
                              weightKg: double.parse(weight.text.trim()),
                              heightCm: double.parse(height.text.trim()));
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
                      setState(() => result = null);
                    }),
                const SizedBox(height: 8),
                ResultPanel(
                    value: result,
                    detail: result == null
                        ? 'การแปลผล'
                        : HealthCalculator.bmiCategory(result!)),
              ]))));
}
