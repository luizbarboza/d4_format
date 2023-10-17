import 'dart:math';

import 'exponent.dart';
import 'locale.dart';

/// Returns a suggested decimal precision for use with
/// [FormatLocale.formatPrefix] given the specified numeric step and reference
/// [value].
///
/// ```dart
/// precisionPrefix(1e5, 1.3e6) // 1
/// ```
///
/// The [step] represents the minimum absolute difference between values that
/// will be formatted, and [value] determines which SI prefix will be used.
/// (This assumes that the values to be formatted are also multiples of [step].)
/// For example, given the numbers 1.1e6, 1.2e6, and 1.3e6, the [step] should be
/// 1e5, the [value] could be 1.3e6, and the suggested precision is 1:
///
/// ```dart
/// final p = precisionPrefix(1e5, 1.3e6);
/// final f = formatPrefix(".${p}", 1.3e6);
/// f(1.1e6); // "1.1M"
/// f(1.2e6); // "1.2M"
/// f(1.3e6); // "1.3M"
/// ```
num precisionPrefix(num step, num value) {
  if (!step.isFinite) return double.nan;
  return max(
      0,
      (value.isFinite ? max(-8, min(8, (exponent(value)! / 3).floor())) : 8) *
              3 -
          exponent(step.abs())!);
}
