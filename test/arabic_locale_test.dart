import 'dart:convert';
import 'dart:io';

import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  locale(String locale) {
    return FormatLocale.fromJson(
        jsonDecode(File("./test/locale/$locale.json").readAsStringSync()));
  }

  test("formatLocale() can format numbers using ar-001 locale", () {
    expect(locale("ar-001").format("\$,.2f")(-1234.56), "−١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-AE locale", () {
    expect(locale("ar-AE").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ د.إ.");
  });

  test("formatLocale() can format numbers using ar-BH locale", () {
    expect(locale("ar-BH").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ د.ب.");
  });

  test("formatLocale() can format numbers using ar-DJ locale", () {
    expect(locale("ar-DJ").format("\$,.2f")(1234.56), "\u200fFdj ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-DZ locale", () {
    expect(locale("ar-DZ").format("\$,.2f")(1234.56), "د.ج. 1.234,56");
  });

  test("formatLocale() can format numbers using ar-EG locale", () {
    expect(locale("ar-EG").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ج.م.");
  });

  test("formatLocale() can format numbers using ar-EH locale", () {
    expect(locale("ar-EH").format("\$,.2f")(1234.56), "د.م. 1,234.56");
  });

  test("formatLocale() can format numbers using ar-ER locale", () {
    expect(locale("ar-ER").format("\$,.2f")(1234.56), "Nfk ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-IL locale", () {
    expect(locale("ar-IL").format("\$,.2f")(1234.56), "₪ ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-IQ locale", () {
    expect(locale("ar-IQ").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ د.ع.");
  });

  test("formatLocale() can format numbers using ar-JO locale", () {
    expect(locale("ar-JO").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ د.أ.");
  });

  test("formatLocale() can format numbers using ar-KM locale", () {
    expect(locale("ar-KM").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ف.ج.ق.");
  });

  test("formatLocale() can format numbers using ar-KW locale", () {
    expect(locale("ar-KW").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ د.ك.");
  });

  test("formatLocale() can format numbers using ar-LB locale", () {
    expect(locale("ar-LB").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ل.ل.");
  });

  test("formatLocale() can format numbers using ar-MA locale", () {
    expect(locale("ar-MA").format("\$,.2f")(1234.56), "د.م. 1.234,56");
  });

  test("formatLocale() can format numbers using ar-MR locale", () {
    expect(locale("ar-MR").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ أ.م.");
  });

  test("formatLocale() can format numbers using ar-OM locale", () {
    expect(locale("ar-OM").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ر.ع.");
  });

  test("formatLocale() can format numbers using ar-PS locale", () {
    expect(locale("ar-PS").format("\$,.2f")(1234.56), "₪ ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-QA locale", () {
    expect(locale("ar-QA").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ر.ق.");
  });

  test("formatLocale() can format numbers using ar-SA locale", () {
    expect(locale("ar-SA").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ر.س.");
  });

  test("formatLocale() can format numbers using ar-SD locale", () {
    expect(locale("ar-SD").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ج.س.");
  });

  test("formatLocale() can format numbers using ar-SO locale", () {
    expect(locale("ar-SO").format("\$,.2f")(1234.56), "‏S ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-SS locale", () {
    expect(locale("ar-SS").format("\$,.2f")(1234.56), "£ ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-SY locale", () {
    expect(locale("ar-SY").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ل.س.");
  });

  test("formatLocale() can format numbers using ar-TD locale", () {
    expect(locale("ar-TD").format("\$,.2f")(1234.56), "\u200fFCFA ١٬٢٣٤٫٥٦");
  });

  test("formatLocale() can format numbers using ar-TN locale", () {
    expect(locale("ar-TN").format("\$,.2f")(1234.56), "د.ت. 1.234,56");
  });

  test("formatLocale() can format numbers using ar-YE locale", () {
    expect(locale("ar-YE").format("\$,.2f")(1234.56), "١٬٢٣٤٫٥٦ ر.ى.");
  });
}
