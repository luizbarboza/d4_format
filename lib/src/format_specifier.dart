import 'dart:math';

import 'locale.dart';
import 'precision_fixed.dart';

final RegExp _re = RegExp(
    r'^(?:(.)?([<>=^]))?([+\-( ])?([$#])?(0)?(\d+)?(,)?(\.\d+)?(~)?([a-z%])?$',
    caseSensitive: false);

/// Format specifiers define how a number should be formatted (see
/// [FormatLocale.format]) and can be created and derived in a structured way.
///
/// ```dart
/// final s = FormatSpecifier(type: "f");
/// s.precision = precisionFixed(0.01) as int;
/// final f = format(s.toString());
/// f(42); // "42.00";
/// ```
class FormatSpecifier {
  String fill;
  String align;
  String sign;
  String symbol;
  bool zero;
  int? width;
  bool comma;
  int? precision;
  bool trim;
  String type;

  /// Constructs an object with exposed fields that correspond to the format
  /// specification mini-language (see [FormatLocale.format]) and a [toString]
  /// method that reconstructs the specifier.
  ///
  /// For example, `FormatSpecifier(type: "s")` returns:
  ///
  /// ```dart
  /// FormatSpecifier(
  ///   fill: " ",
  ///   align: ">",
  ///   sign: "-",
  ///   symbol: "",
  ///   zero: false,
  ///   width: null,
  ///   comma: false,
  ///   precision: null,
  ///   trim: false,
  ///   type: "s"
  /// );
  /// ```
  FormatSpecifier({
    String? fill,
    String? align,
    String? sign,
    String? symbol,
    bool? zero,
    this.width,
    bool? comma,
    this.precision,
    bool? trim,
    String? type,
  })  : fill = fill ?? ' ',
        align = align ?? '>',
        sign = sign ?? '-',
        symbol = symbol ?? '',
        zero = zero ?? false,
        comma = comma ?? false,
        trim = trim ?? false,
        type = type ?? '';

  /// Parses the specified [specifier], returning an object with exposed fields
  /// that correspond to the format specification mini-language (see
  /// [FormatLocale.format]) and a [toString] method that reconstructs the
  /// specifier.
  ///
  /// For example,
  /// `FormatSpecifier.parse("s")` returns:
  ///
  /// ```dart
  /// FormatSpecifier(
  ///   fill: " ",
  ///   align: ">",
  ///   sign: "-",
  ///   symbol: "",
  ///   zero: false,
  ///   width: null,
  ///   comma: false,
  ///   precision: null,
  ///   trim: false,
  ///   type: "s"
  /// );
  /// ```
  ///
  /// This method is useful for understanding how format specifiers are parsed
  /// and for deriving new specifiers. For example, you might compute an
  /// appropriate precision based on the numbers you want to format using
  /// [precisionFixed] and then create a new format:
  ///
  /// ```dart
  /// final s = FormatSpecifier.parse("f");
  /// s.precision = precisionFixed(0.01) as int;
  /// final f = format(s.toString());
  /// f(42); // "42.00";
  /// ```
  static FormatSpecifier parse(String specifier) {
    FormatSpecifier? result = FormatSpecifier.tryParse(specifier);
    if (result != null) return result;
    throw FormatException('invalid format: $specifier');
  }

  /// Like [parse], except that this function returns null for invalid inputs
  /// instead of throwing.
  static FormatSpecifier? tryParse(String specifier) {
    final Match? match = _re.firstMatch(specifier);
    if (match == null) return null;

    return FormatSpecifier(
      fill: match.group(1),
      align: match.group(2),
      sign: match.group(3),
      symbol: match.group(4),
      zero: match.group(5) != null,
      width: match.group(6) != null ? int.parse(match.group(6)!) : null,
      comma: match.group(7) != null,
      precision: match.group(8) != null
          ? int.parse(match.group(8)!.substring(1))
          : null,
      trim: match.group(9) != null,
      type: match.group(10),
    );
  }

  @override
  String toString() {
    return fill +
        align +
        sign +
        symbol +
        (zero ? '0' : '') +
        (width == null ? '' : max(1, width!).toString()) +
        (comma ? ',' : '') +
        (precision == null ? '' : '.${max(0, precision!)}') +
        (trim ? '~' : '') +
        type;
  }
}
