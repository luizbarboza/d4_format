import 'dart:math';

import 'exponent.dart';

/// Returns a suggested decimal precision for fixed point notation given the
/// specified numeric [step] value.
///
/// ```dart
/// precisionFixed(0.01) // 2
/// ```
///
/// The [step] represents the minimum absolute difference between values that
/// will be formatted. (This assumes that the values to be formatted are also
/// multiples of [step].) For example, given the numbers 1, 1.5, and 2, the
/// [step] should be 0.5 and the suggested precision is 1:
///
/// ```dart
/// final p = precisionFixed(0.5);
/// final f = format(".${p}f");
/// f(1);   // "1.0"
/// f(1.5); // "1.5"
/// f(2);   // "2.0"
/// ```
///
/// Whereas for the numbers 1, 2 and 3, the [step] should be 1 and the suggested
/// precision is 0:
///
/// ```dart
/// final p = precisionFixed(1);
/// final f = format(".${p}f");
/// f(1); // "1"
/// f(2); // "2"
/// f(3); // "3"
/// ```
///
/// Note: for the `%` format type, subtract two:
///
/// final p = max(0, precisionFixed(0.05) - 2);
/// final f = format(".${p}%");
/// f(0.45); // "45%"
/// f(0.50); // "50%"
/// f(0.55); // "55%"
num precisionFixed(num step) {
  if (!step.isFinite) return double.nan;
  return max(0, -exponent(step.abs())!);
}
