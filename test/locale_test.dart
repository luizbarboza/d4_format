import 'dart:convert';
import 'dart:io';

import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  locale(String locale) {
    return FormatLocale.fromJson(
        jsonDecode(File("./test/locale/$locale.json").readAsStringSync()));
  }

  test("FormatLocale({decimal: decimal}) observes the specified decimal point",
      () {
    expect(FormatLocale(decimal: "|").format("06.2f")(2), "002|00");
    expect(FormatLocale(decimal: "/").format("06.2f")(2), "002/00");
  });

  test(
      "FormatLocale({currency: [prefix, suffix]}) observes the specified currency prefix and suffix",
      () {
    expect(FormatLocale(decimal: ".", currency: ["฿", ""]).format(r"$06.2f")(2),
        "฿02.00");
    expect(FormatLocale(decimal: ".", currency: ["", "฿"]).format(r"$06.2f")(2),
        "02.00฿");
  });

  test(
      "FormatLocale({currency: [prefix, suffix]}) places the currency suffix after the SI suffix",
      () {
    expect(
        FormatLocale(decimal: ",", currency: ["", " €"]).format(r"$.3s")(1.2e9),
        "1,20G €");
  });

  test("FormatLocale({grouping: undefined}) does not perform any grouping", () {
    expect(FormatLocale(decimal: ".").format("012,.2f")(2), "000000002.00");
  });

  test("FormatLocale({grouping: [sizes…]}) observes the specified group sizes",
      () {
    expect(
        FormatLocale(decimal: ".", grouping: [3], thousands: ",")
            .format("012,.2f")(2),
        "0,000,002.00");
    expect(
        FormatLocale(decimal: ".", grouping: [2], thousands: ",")
            .format("012,.2f")(2),
        "0,00,00,02.00");
    expect(
        FormatLocale(decimal: ".", grouping: [2, 3], thousands: ",")
            .format("012,.2f")(2),
        "00,000,02.00");
    expect(
        FormatLocale(
                decimal: ".", grouping: [3, 2, 2, 2, 2, 2, 2], thousands: ",")
            .format(",d")(1e12),
        "10,00,00,00,00,000");
  });

  test("FormatLocale(…) can format numbers using the Indian numbering system.",
      () {
    final format = locale("en-IN").format(",");
    expect(format(10), "10");
    expect(format(100), "100");
    expect(format(1000), "1,000");
    expect(format(10000), "10,000");
    expect(format(100000), "1,00,000");
    expect(format(1000000), "10,00,000");
    expect(format(10000000), "1,00,00,000");
    expect(format(10000000.4543), "1,00,00,000.4543");
    expect(format(1000.321), "1,000.321");
    expect(format(10.5), "10.5");
    expect(format(-10), "−10");
    expect(format(-100), "−100");
    expect(format(-1000), "−1,000");
    expect(format(-10000), "−10,000");
    expect(format(-100000), "−1,00,000");
    expect(format(-1000000), "−10,00,000");
    expect(format(-10000000), "−1,00,00,000");
    expect(format(-10000000.4543), "−1,00,00,000.4543");
    expect(format(-1000.321), "−1,000.321");
    expect(format(-10.5), "−10.5");
  });

  test(
      "FormatLocale({thousands: separator}) observes the specified group separator",
      () {
    expect(
        FormatLocale(decimal: ".", grouping: [3], thousands: " ")
            .format("012,.2f")(2),
        "0 000 002.00");
    expect(
        FormatLocale(decimal: ".", grouping: [3], thousands: "/")
            .format("012,.2f")(2),
        "0/000/002.00");
  });

  test("FormatLocale({percent: percent}) observes the specified percent sign",
      () {
    expect(
        FormatLocale(decimal: ".", percent: "!").format("06.2%")(2), "200.00!");
    expect(
        FormatLocale(decimal: ".", percent: "﹪").format("06.2%")(2), "200.00﹪");
  });

  test("FormatLocale({minus: minus}) observes the specified minus sign", () {
    expect(
        FormatLocale(decimal: ".", minus: "-").format("06.2f")(-2), "-02.00");
    expect(
        FormatLocale(decimal: ".", minus: "−").format("06.2f")(-2), "−02.00");
    expect(
        FormatLocale(decimal: ".", minus: "➖").format("06.2f")(-2), "➖02.00");
    expect(FormatLocale(decimal: ".").format("06.2f")(-2), "−02.00");
  });

  test(
      "FormatLocale({nan: nan}) observes the specified not-a-number representation",
      () {
    expect(FormatLocale(nan: "N/A").format("6.2f")(null), "   N/A");
    expect(FormatLocale(nan: "-").format("<6.2g")(null), "-     ");
    expect(FormatLocale().format(" 6.2f")(null), "   NaN");
  });

  test("locale data is valid", () async {
    for (var file in Directory("./test/locale/").listSync()) {
      final locale = jsonDecode((file as File).readAsStringSync());
      expect(locale, contains("currency"));
      expect(locale, contains("decimal"));
      expect(locale, contains("grouping"));
      expect(locale, contains("thousands"));
      FormatLocale.fromJson(locale);
    }
  });
}
