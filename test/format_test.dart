import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(specifier)(number) returns a string", () {
    expect(format("d")(0), isA<String>());
  });

  /*test("format(specifier).toString() returns the normalized specifier", () {
    expect(format("d").toString(), " >-d");
  });*/

  test("format(specifier) throws an error for invalid formats", () {
    expect(() {
      format("foo");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: foo'))));
    expect(() {
      format(".-2s");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: .-2s'))));
    expect(() {
      format(".f");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: .f'))));
  });

  test(
      "format(\",.\") unreasonable precision values are clamped to reasonable values",
      () {
    expect(format(".30f")(0), "0.00000000000000000000");
    expect(format(".0g")(1), "1");
  });

  test("format(\"s\") handles very small and very large values", () {
    expect(format("s")(double.minPositive),
        "0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005y");
    expect(format("s")(double.maxFinite),
        "179769000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000Y");
  });

  test("format(\"n\") is equivalent to format(\",g\")", () {
    expect(format("n")(123456.78), "123,457");
    expect(format(",g")(123456.78), "123,457");
  });

  test("format(\"012\") is equivalent to format(\"0=12\")", () {
    expect(format("012")(123.456), "00000123.456");
    expect(format("0=12")(123.456), "00000123.456");
  });
}
