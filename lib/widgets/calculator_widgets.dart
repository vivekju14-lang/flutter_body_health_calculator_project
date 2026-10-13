import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  const NumberInput(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      this.integer = false});
  final String label, hint;
  final TextEditingController controller;
  final bool integer;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: !integer),
            validator: (v) {
              final n = double.tryParse((v ?? '').trim());
              if (n == null || !n.isFinite || n <= 0) {
                return 'กรุณากรอกตัวเลขมากกว่า 0';
              }
              if (integer && (n != n.roundToDouble() || n > 120)) {
                return 'กรุณากรอกอายุเป็นจำนวนเต็ม 1–120 ปี';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero))),
        const SizedBox(height: 12)
      ]);
}

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.reset = false});
  final String label;
  final VoidCallback onPressed;
  final bool reset;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      reset ? Colors.grey : const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  elevation: 0),
              onPressed: onPressed,
              child: Text(label))));
}

class ResultPanel extends StatelessWidget {
  const ResultPanel({super.key, required this.value, required this.detail});
  final double? value;
  final String detail;
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFC8E6C9),
      child: Column(children: [
        const Text('ผล'),
        Text((value ?? 0).toStringAsFixed(2),
            style: const TextStyle(
                color: Color(0xFFFF5722),
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        Text(detail,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))
      ]));
}

void invalidResult(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ข้อมูลอยู่นอกช่วงที่คำนวณได้ กรุณาตรวจสอบข้อมูล')));
