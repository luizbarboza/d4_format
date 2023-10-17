import 'locale.dart';

FormatLocale _locale =
    formatDefaultLocale(thousands: ",", grouping: [3], currency: ["\$", ""]);

String Function(Object?) Function(String) _format = _locale.format;
String Function(num) Function(String, num) _formatPrefix = _locale.formatPrefix;

/// An alias for [FormatLocale.format] on the default locale (see
/// [formatDefaultLocale]).
///
/// ```dart
/// final f = format(".2f");
/// ```
String Function(Object?) format(String specifier) {
  return _format(specifier);
}

/// An alias for [FormatLocale.formatPrefix] on the default locale (see
/// [formatDefaultLocale]).
String Function(num) formatPrefix(String specifier, num value) {
  return _formatPrefix(specifier, value);
}

/// Equivalent to [FormatLocale.new], except it also redefines [format] and
/// [formatPrefix] to the new locale’s [FormatLocale.format] and
/// [FormatLocale.formatPrefix].
///
/// ```dart
/// final enUs = formatDefaultLocale(
///   thousands: ",",
///   grouping: [3],
///   currency: ["$", ""],
/// );
/// ```
///
/// If you do not set a default locale, it defaults to
/// [U.S. English](https://github.com/luizbarboza/d4_format/blob/main/test/locale/en-US.json).
FormatLocale formatDefaultLocale(
    {String? decimal,
    String? thousands,
    List<int>? grouping,
    List<String>? currency,
    List<String>? numerals,
    String? percent,
    String? minus,
    String? nan}) {
  _locale = FormatLocale(
      decimal: decimal,
      thousands: thousands,
      grouping: grouping,
      currency: currency,
      numerals: numerals,
      percent: percent,
      minus: minus,
      nan: nan);
  _format = _locale.format;
  _formatPrefix = _locale.formatPrefix;
  return _locale;
}

/// Equivalent to [formatDefaultLocale], but it accepts a JSON [definition]
/// object instead of individual arguments.
FormatLocale formatDefaultLocaleFromJson(Map<String, dynamic> definition) {
  _locale = FormatLocale.fromJson(definition);
  _format = _locale.format;
  _formatPrefix = _locale.formatPrefix;
  return _locale;
}
