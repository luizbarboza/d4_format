/// Format numbers for human consumption.
///
/// Ever noticed how sometimes Dart doesn’t display numbers the way you expect?
/// Like, you tried to print tenths with a simple loop:
///
/// ```dart
/// for (var i = 0; i < 10; ++i) {
///   print(0.1 * i);
/// }
/// ```
///
/// And you got this:
///
/// ```dart
/// 0
/// 0.1
/// 0.2
/// 0.30000000000000004
/// 0.4
/// 0.5
/// 0.6000000000000001
/// 0.7000000000000001
/// 0.8
/// 0.9
/// ```
///
/// Welcome to binary floating point! ಠ_ಠ
///
/// Yet rounding error is not the only reason to customize number formatting. A
/// table of numbers should be formatted consistently for comparison; above, 0.0
/// would be better than 0. Large numbers should have grouped digits (e.g.,
/// 42,000) or be in scientific or metric notation (4.2e+4, 42k). Currencies
/// should have fixed precision ($3.50). Reported numerical results should be
/// rounded to significant digits (4021 becomes 4000). Number formats should
/// appropriate to the reader’s locale (42.000,00 or 42,000.00). The list goes
/// on.
///
/// Formatting numbers for human consumption is the purpose of d4+format, which
/// is modeled after Python 3’s
/// [format specification mini-language](https://docs.python.org/3/library/string.html#format-specification-mini-language)
/// ([PEP 3101](https://www.python.org/dev/peps/pep-3101/)). Revisiting the
/// example above:
///
/// ```dart
/// final f = format(".1f");
/// for (var i = 0; i < 10; ++i) {
///   print(f(0.1 * i));
/// }
/// ```
///
/// Now you get this:
///
/// ```dart
/// 0.0
/// 0.1
/// 0.2
/// 0.3
/// 0.4
/// 0.5
/// 0.6
/// 0.7
/// 0.8
/// 0.9
/// ```
///
/// But d4_format is much more than an alias for [num.toStringAsFixed]! A few
/// more examples:
///
/// ```dart
/// format(".0%")(0.123); // rounded percentage, "12%"
/// ```
///
/// ```dart
/// format("(\$.2f")(-3.5); // localized fixed-point currency, "(£3.50)"
/// ```
///
/// ```dart
/// format("+20")(42); // space-filled and signed, "                 +42"
/// ```
///
/// ```dart
/// format(".^20")(42); // dot-filled and centered, ".........42........."
/// ```
///
/// ```dart
/// format(".2s")(42e6); // SI-prefix with two significant digits, "42M"
/// ```
///
/// ```dart
/// format("#x")(48879); // prefixed lowercase hexadecimal, "0xbeef"
/// ```
///
/// ```dart
/// format(",.2r")(4223); // grouped thousands with two significant digits, "4,200"
/// ```
///
/// See [FormatLocale.format] for a detailed specification, and try running
/// [FormatSpecifier.parse] on the above formats to decode their meaning.
export 'src/d4_format.dart';
import 'src/d4_format.dart';
