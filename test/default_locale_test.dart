import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  const enUs = {
    "decimal": ".",
    "thousands": ",",
    "grouping": [3],
    "currency": ["\$", ""]
  };

  const frFr = {
    "decimal": ",",
    "thousands": ".",
    "grouping": [3],
    "currency": ["", "\u00a0€"],
    "percent": "\u202f%"
  };

  test("formatDefaultLocale(definition) returns the new default locale", () {
    final locale = formatDefaultLocaleFromJson(frFr);
    try {
      expect(locale.format(r"$,.2f")(12345678.90), "12.345.678,90 €");
      expect(locale.format(",.0%")(12345678.90), "1.234.567.890\u202f%");
    } finally {
      formatDefaultLocaleFromJson(enUs);
    }
  });

  test("formatDefaultLocale(definition) affects format", () {
    formatDefaultLocaleFromJson(frFr);
    try {
      expect(format(r"$,.2f")(12345678.90), "12.345.678,90 €");
    } finally {
      formatDefaultLocaleFromJson(enUs);
    }
  });

  test("formatDefaultLocale(definition) affects formatPrefix", () {
    formatDefaultLocaleFromJson(frFr);
    try {
      expect(formatPrefix(",.2", 1e3)(12345678.90), "12.345,68k");
    } finally {
      formatDefaultLocaleFromJson(enUs);
    }
  });
}
