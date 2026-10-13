enum BiologicalSex { male, female }

class HealthCalculator {
  static void _positive(double value, String label) {
    if (!value.isFinite || value <= 0) {
      throw ArgumentError.value(value, label, 'Must be finite and positive');
    }
  }

  static double bmi({required double weightKg, required double heightCm}) {
    _positive(weightKg, 'weightKg');
    _positive(heightCm, 'heightCm');
    final metres = heightCm / 100;
    final result = weightKg / (metres * metres);
    if (!result.isFinite) throw ArgumentError('Measurements are out of range');
    return result;
  }

  // Classification thresholds are those supplied in the course mockup.
  // Classify using the unrounded result, then round only for display.
  static String bmiCategory(double value) {
    _positive(value, 'bmi');
    if (value < 18.5) return 'น้ำหนักต่ำกว่าเกณฑ์';
    if (value < 23) return 'น้ำหนักสมส่วน';
    if (value < 25) return 'น้ำหนักเกิน';
    if (value < 30) return 'โรคอ้วนระดับ 1';
    return 'โรคอ้วนระดับ 2 หรืออ้วนมาก';
  }

  // Revised Harris–Benedict equations specified by the instructor.
  static double bmr({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required BiologicalSex sex,
  }) {
    _positive(weightKg, 'weightKg');
    _positive(heightCm, 'heightCm');
    if (ageYears <= 0) throw ArgumentError.value(ageYears, 'ageYears');
    final result = sex == BiologicalSex.male
        ? 88.362 + 13.397 * weightKg + 4.799 * heightCm - 5.677 * ageYears
        : 447.593 + 9.247 * weightKg + 3.098 * heightCm - 4.330 * ageYears;
    if (!result.isFinite || result <= 0) {
      throw ArgumentError('Measurements are out of range');
    }
    return result;
  }
}
