import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_body_health_calculator_project/models/health_calculator.dart';

void main() {
  test('BMI converts centimetres to metres', () {
    expect(HealthCalculator.bmi(weightKg: 70, heightCm: 175),
        closeTo(22.857142857, 0.000001));
  });
  test('BMI classification handles every boundary without rounding first', () {
    expect(HealthCalculator.bmiCategory(18.499), 'น้ำหนักต่ำกว่าเกณฑ์');
    expect(HealthCalculator.bmiCategory(18.5), 'น้ำหนักสมส่วน');
    expect(HealthCalculator.bmiCategory(22.999), 'น้ำหนักสมส่วน');
    expect(HealthCalculator.bmiCategory(23), 'น้ำหนักเกิน');
    expect(HealthCalculator.bmiCategory(25), 'โรคอ้วนระดับ 1');
    expect(HealthCalculator.bmiCategory(30), 'โรคอ้วนระดับ 2 หรืออ้วนมาก');
  });
  test('BMR uses both instructor equations', () {
    expect(
        HealthCalculator.bmr(
            weightKg: 70, heightCm: 175, ageYears: 30, sex: BiologicalSex.male),
        closeTo(1695.667, 0.001));
    expect(
        HealthCalculator.bmr(
            weightKg: 70,
            heightCm: 175,
            ageYears: 30,
            sex: BiologicalSex.female),
        closeTo(1507.133, 0.001));
  });
  test('invalid measurements are rejected', () {
    expect(() => HealthCalculator.bmi(weightKg: 70, heightCm: 0),
        throwsArgumentError);
    expect(() => HealthCalculator.bmi(weightKg: double.nan, heightCm: 175),
        throwsArgumentError);
    expect(
        () => HealthCalculator.bmr(
            weightKg: 70, heightCm: 175, ageYears: 0, sex: BiologicalSex.male),
        throwsArgumentError);
  });
}
