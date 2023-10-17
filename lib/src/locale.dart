import 'dart:math';

import 'package:d4_format/src/format_numerals.dart';

import 'exponent.dart';
import 'format_group.dart';
import 'format_prefix_auto.dart';
import 'format_specifier.dart';
import 'format_trim.dart';
import 'format_types.dart';
import 'identity.dart';
import 'precision_fixed.dart';
import 'precision_prefix.dart';
import 'precision_round.dart';

const _prefixes = [
  "y",
  "z",
  "a",
  "f",
  "p",
  "n",
  "µ",
  "m",
  "",
  "k",
  "M",
  "G",
  "T",
  "P",
  "E",
  "Z",
  "Y"
];

/// Locale formats define how a value ​​should be formatted in a locale-specific
/// way.
class FormatLocale {
  String Function(String, int?) _group;
  String _currencyPrefix;
  String _currencySuffix;
  String _decimal;
  String Function(String) _numerals;
  String _percent;
  String _minus;
  String _nan;

  /// Constructs a *locale* object for the specified definition with [format]
  /// and [formatPrefix] methods.
  ///
  /// ```dart
  /// final enUs = FormatLocale(
  ///   thousands: ",",
  ///   grouping: [3],
  ///   currency: ["$", ""],
  /// );
  /// ```
  ///
  /// The *definition* must include the following properties:
  ///
  /// * `decimal` - the decimal point (e.g., `"."`).
  /// * `thousands` - the group separator (e.g., `","`).
  /// * `grouping` - the list of group sizes (e.g., `[3]`), cycled as needed.
  /// * `currency` - the currency prefix and suffix (e.g., `["$", ""]`).
  /// * `numerals` - optional; an list of ten strings to replace the numerals 0-9.
  /// * `percent` - optional; the percent sign (defaults to `"%"`).
  /// * `minus` - optional; the minus sign (defaults to `"−"`).
  /// * `nan` - optional; the not-a-number value (defaults `"NaN"`).
  ///
  /// Note that the [thousands] property is a misnomer, as the grouping
  /// definition allows groups other than thousands.
  FormatLocale(
      {String? decimal,
      String? thousands,
      List<int>? grouping,
      List<String>? currency,
      List<String>? numerals,
      String? percent,
      String? minus,
      String? nan})
      : _group = (grouping == null || thousands == null
            ? identity<String, int>
            : formatGroup(grouping, thousands)),
        _currencyPrefix = currency?.elementAtOrNull(0) ?? "",
        _currencySuffix = currency?.elementAtOrNull(1) ?? "",
        _decimal = decimal ?? ".",
        _numerals = numerals == null ? identity : formatNumerals(numerals),
        _percent = percent ?? "%",
        _minus = minus ?? "−",
        _nan = nan ?? "NaN";

  /// Equivalent to [FormatLocale.new], but it accepts a JSON [definition]
  /// object instead of individual arguments.
  factory FormatLocale.fromJson(Map<String, dynamic> definition) {
    return FormatLocale(
        decimal: definition["decimal"],
        thousands: definition["thousands"],
        grouping: definition["grouping"]?.cast<int>(),
        currency: definition["currency"]?.cast<String>(),
        numerals: definition["numerals"]?.cast<String>(),
        percent: definition["percent"],
        minus: definition["minus"],
        nan: definition["nan"]);
  }

  /// Returns a new format function for the given string [specifier]. The
  /// returned function takes a number as the only argument, and returns a
  /// string representing the formatted number.
  ///
  /// The general form of a [specifier] is:
  ///
  /// ```
  /// [​[fill]align][sign][symbol][0][width][,][.precision][~][type]
  /// ```
  ///
  /// The *fill* can be any character. The presence of a fill character is
  /// signaled by the *align* character following it, which must be one of the
  /// following:
  ///
  /// * `>` - Forces the field to be right-aligned within the available space.
  /// (Default behavior).
  /// * `<` - Forces the field to be left-aligned within the available space.
  /// * `^` - Forces the field to be centered within the available space.
  /// * `=` - like `>`, but with any sign and symbol to the left of any
  /// padding.
  ///
  /// The *sign* can be:
  ///
  /// * `-` - nothing for zero or positive and a minus sign for negative.
  /// (Default behavior.)
  /// * `+` - a plus sign for zero or positive and a minus sign for negative.
  /// * `(` - nothing for zero or positive and parentheses for negative.
  /// * ` ` (space) - a space for zero or positive and a minus sign for
  /// negative.
  ///
  /// The *symbol* can be:
  ///
  /// * `$` - apply currency symbols per the locale definition.
  /// * `#` - for binary, octal, or hexadecimal notation, prefix by `0b`,
  /// `0o`, or `0x`, respectively.
  ///
  /// The *zero* (`0`) option enables zero-padding; this implicitly sets
  /// *fill* to `0` and align to `=`. The *width* defines the minimum field
  /// width; if not specified, then the width will be determined by the
  /// content. The *comma* (`,`) option enables the use of a group separator,
  /// such as a comma for thousands.
  ///
  /// Depending on the *type*, the *precision* either indicates the number of
  /// digits that follow the decimal point (types `f` and `%`), or the number
  /// of significant digits (types ` `​, `e`, `g`, `r`, `s` and `p`). If the
  /// precision is not specified, it defaults to 6 for all types except ​` `
  /// (none), which defaults to 12. Precision is ignored for integer formats
  /// (types `b`, `o`, `d`, `x`, and `X`) and character data (type `c`). See
  /// [precisionFixed] and [precisionRound] for help picking an appropriate
  /// precision.
  ///
  /// The `~` option trims insignificant trailing zeros across all format types.
  /// This is most commonly used in conjunction with types `r`, `e`, `s` and
  /// `%`. For example:
  ///
  /// ```dart
  /// format("s")(1500); // "1.50000k"
  /// ```
  /// ```dart
  /// format("~s")(1500); // "1.5k"
  /// ```
  ///
  /// The available *type* values are:
  ///
  /// * `e` - exponent notation.
  /// * `f` - fixed point notation.
  /// * `g` - either decimal or exponent notation, rounded to significant
  /// digits.
  /// * `r` - decimal notation, rounded to significant digits.
  /// * `s` - decimal notation with an
  /// [SI prefix](https://d3js.org/d3-format#locale_formatPrefix), rounded to
  /// significant digits.
  /// * `%` - multiply by 100, and then decimal notation with a percent sign.
  /// * `p` - multiply by 100, round to significant digits, and then decimal
  /// notation with a percent sign.
  /// * `b` - binary notation, rounded to integer.
  /// * `o` - octal notation, rounded to integer.
  /// * `d` - decimal notation, rounded to integer.
  /// * `x` - hexadecimal notation, using lower-case letters, rounded to
  /// integer.
  /// * `X` - hexadecimal notation, using upper-case letters, rounded to
  /// integer.
  /// * `c` - character data, for a string of text.
  ///
  /// The type ` `​ (none) is also supported as shorthand for `~g` (with a
  /// default precision of 12 instead of 6), and the type n is shorthand for
  /// `,g`. For the `g`, `n` and ` `​ (none) types, decimal notation is used if
  /// the resulting string would have *precision* or fewer digits; otherwise,
  /// exponent notation is used. For example:
  ///
  /// ```dart
  /// format(".2")(42); // "42"
  /// ```
  /// ```dart
  /// format(".2")(42); // "42"
  /// ```
  /// ```dart
  /// format(".2")(42); // "42"
  /// ```
  /// ```dart
  /// format(".2")(42); // "42"
  /// ```
  String Function(Object?) format(String specifier) {
    var specifier0 = FormatSpecifier.parse(specifier);

    var fill = specifier0.fill,
        align = specifier0.align,
        sign = specifier0.sign,
        symbol = specifier0.symbol,
        zero = specifier0.zero,
        width = specifier0.width,
        comma = specifier0.comma,
        precision = specifier0.precision,
        trim = specifier0.trim,
        type = specifier0.type;

    // The "n" type is an alias for ",g".
    if (type == "n") {
      comma = true;
      type = "g";
    }

    // The "" type, and any invalid type, is an alias for ".12~g".
    else if (!formatTypes.containsKey(type)) {
      precision ??= 12;
      trim = true;
      type = "g";
    }

    // If zero fill is specified, padding goes after sign and before digits.
    if (zero || (fill == "0" && align == "=")) {
      zero = true;
      fill = "0";
      align = "=";
    }

    // Compute the prefix and suffix.
    // For SI-prefix, the suffix is lazily computed.
    var prefix = symbol == "\$"
            ? _currencyPrefix
            : symbol == "#" && type.contains(RegExp(r'[boxX]'))
                ? "0${type.toLowerCase()}"
                : "",
        suffix = symbol == "\$"
            ? _currencySuffix
            : type.contains(RegExp(r'[%p]'))
                ? _percent
                : "";

    // What format function should we use?
    // Is this an integer type?
    // Can this type generate exponential notation?
    var formatType = formatTypes[type],
        maybeSuffix = type.contains(RegExp(r'[defgprs%]'));

    // Set the default precision if not specified,
    // or clamp the specified precision to the supported range.
    // For significant precision, it must be in [1, 21].
    // For fixed precision, it must be in [0, 20].
    precision = precision == null
        ? 6
        : type.contains(RegExp(r'[gprs]'))
            ? max(1, min(21, precision))
            : max(0, min(20, precision));

    format(Object? value) {
      var valuePrefix = prefix, valueSuffix = suffix;
      int i, n, c;
      String value0;

      if (type == "c") {
        valueSuffix = value.toString() + valueSuffix;
        value0 = "";
      } else {
        bool valueNegative = false;

        // Perform the initial formatting.
        if (value is! num || value.isNaN) {
          value0 = _nan;
        } else {
          valueNegative = value.isNegative;
          value0 = formatType!(value.abs(), precision!);
        }

        // Trim insignificant zeros.
        if (trim) value0 = formatTrim(value0);

        // If a negative value rounds to zero after formatting, and no explicit positive sign is requested, hide the sign.
        if (valueNegative && num.tryParse(value0)?.sign == 0 && sign != "+") {
          valueNegative = false;
        }

        // Compute the prefix and suffix.
        valuePrefix = (valueNegative
                ? (sign == "(" ? sign : _minus)
                : sign == "-" || sign == "("
                    ? ""
                    : sign) +
            valuePrefix;
        valueSuffix = (type == "s" ? _prefixes[8 + prefixExponent! ~/ 3] : "") +
            valueSuffix +
            (valueNegative && sign == "(" ? ")" : "");

        // Break the formatted value into the integer “value” part that can be
        // grouped, and fractional or exponential “suffix” part that is not.
        if (maybeSuffix) {
          i = -1;
          n = value0.length;
          while (++i < n) {
            c = value0.codeUnitAt(i);
            if (48 > c || c > 57) {
              valueSuffix = (c == 46
                      ? _decimal + value0.substring(i + 1)
                      : value0.substring(i)) +
                  valueSuffix;
              value0 = value0.substring(0, i);
              break;
            }
          }
        }
      }

      // If the fill character is not "0", grouping is applied before padding.
      if (comma && !zero) value0 = _group(value0, null);

      // Compute the padding.
      var length = valuePrefix.length + value0.length + valueSuffix.length,
          padding =
              width != null && length < width ? fill * (width - length) : "";

      // If the fill character is "0", grouping is applied after padding.
      if (comma && zero) {
        value0 = _group(padding + value0,
            padding.isNotEmpty ? width! - valueSuffix.length : null);
        padding = "";
      }

      // Reconstruct the final output based on the desired alignment.
      switch (align) {
        case "<":
          value0 = valuePrefix + value0 + valueSuffix + padding;
          break;
        case "=":
          value0 = valuePrefix + padding + value0 + valueSuffix;
          break;
        case "^":
          value0 = padding.substring(0, length = padding.length >> 1) +
              valuePrefix +
              value0 +
              valueSuffix +
              padding.substring(length);
          break;
        default:
          value0 = padding + valuePrefix + value0 + valueSuffix;
          break;
      }

      return _numerals(value0);
    }

    return format;
  }

  /// Equivalent to [format], except the returned function will convert values
  /// to the units of the appropriate
  /// [SI prefix](https://en.wikipedia.org/wiki/Metric_prefix#List_of_SI_prefixes)
  /// for the specified numeric reference value before formatting in fixed point
  /// notation.
  ///
  /// The following prefixes are supported:
  ///
  /// * `y` - yocto, 10⁻²⁴
  /// * `z` - zepto, 10⁻²¹
  /// * `a` - atto, 10⁻¹⁸
  /// * `f` - femto, 10⁻¹⁵
  /// * `p` - pico, 10⁻¹²
  /// * `n` - nano, 10⁻⁹
  /// * `µ` - micro, 10⁻⁶
  /// * `m` - milli, 10⁻³
  /// * ` ` (none) - 10⁰
  /// * `k` - kilo, 10³
  /// * `M` - mega, 10⁶
  /// * `G` - giga, 10⁹
  /// * `T` - tera, 10¹²
  /// * `P` - peta, 10¹⁵
  /// * `E` - exa, 10¹⁸
  /// * `Z` - zetta, 10²¹
  /// * `Y` - yotta, 10²⁴
  ///
  /// Unlike [format] with the `s` format type, this method returns a formatter
  /// with a consistent SI prefix, rather than computing the prefix dynamically
  /// for each number. In addition, the *precision* for the given *specifier*
  /// represents the number of digits past the decimal point (as with `f` fixed
  /// point notation), not the number of significant digits. For example:
  ///
  /// ```dart
  /// final f = formatPrefix(",.0", 1e-6);
  /// f(0.00042); // "420µ"
  /// f(0.0042); // "4,200µ"
  /// ```
  ///
  /// This method is useful when formatting multiple numbers in the same units
  /// for easy comparison. See [precisionPrefix] for help picking an appropriate
  /// precision.
  String Function(num) formatPrefix(String specifier, num value) {
    var specifier0 = FormatSpecifier.parse(specifier),
        f = format((specifier0..type = "f").toString()),
        e = max(-8,
                value.isFinite ? min(8, (exponent(value)! / 3).floor()) : 8) *
            3,
        k = num.parse("1e${-e}"),
        prefix = _prefixes[8 + e ~/ 3];
    return (value) {
      return f(k * value) + prefix;
    };
  }
}
