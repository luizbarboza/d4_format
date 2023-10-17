import 'dart:math' as math;

import 'exponent.dart';

/// Returns a suggested decimal precision for format types that round to
/// significant digits given the specified numeric [step] and [max] values.
///
/// ```dart
/// precisionRound(0.01, 1.01) // 3
/// ```
///
/// The [step] represents the minimum absolute difference between values that
/// will be formatted, and the [max] represents the largest absolute value that
/// will be formatted. (This assumes that the values to be formatted are also
/// multiples of [step].) For example, given the numbers 0.99, 1.0, and 1.01,
/// the [step] should be 0.01, the [max] should be 1.01, and the suggested
/// precision is 3:
///
/// ```dart
/// final p = precisionRound(0.01, 1.01);
/// final f = format(".${p}" + "r");
/// f(0.99); // "0.990"
/// f(1.0);  // "1.00"
/// f(1.01); // "1.01"
/// ```
///
/// Whereas for the numbers 0.9, 1.0, and 1.1, the [step] should be 0.1, the
/// [max] should be 1.1, and the suggested precision is 2:
///
/// ```dart
/// final p = precisionRound(0.1, 1.1);
/// final f = format(".${p}r");
/// f(0.9); // "0.90"
/// f(1.0); // "1.0"
/// f(1.1); // "1.1"
/// ```
///
/// Note: for the `e` format type, subtract one:
///
/// ```dart
/// final p = max(0, precisionRound(0.01, 1.01) - 1);
/// final f = format(".${p}e");
/// f(0.01); // "1.00e-2"
/// f(1.01); // "1.01e+0"
/// ```
num precisionRound(num step, num max) {
  if (!step.isFinite || !max.isFinite) return double.nan;
  step = step.abs();
  max = max.abs() - step;
  return math.max(0, exponent(max)! - exponent(step)!) + 1;
}
