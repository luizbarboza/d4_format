import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("formatSpecifier(specifier) throws an exception for invalid formats",
      () {
    expect(() {
      FormatSpecifier.parse("foo");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: foo'))));
    expect(() {
      FormatSpecifier.parse(".-2s");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: .-2s'))));
    expect(() {
      FormatSpecifier.parse(".f");
    },
        throwsA(isA<FormatException>().having(
            (e) => e.message, 'message', contains('invalid format: .f'))));
  });

  test("formatSpecifier(\"\") has the expected defaults", () {
    final s = FormatSpecifier.parse("");
    expect(s.fill, " ");
    expect(s.align, ">");
    expect(s.sign, "-");
    expect(s.symbol, "");
    expect(s.zero, false);
    expect(s.width, null);
    expect(s.comma, false);
    expect(s.precision, null);
    expect(s.trim, false);
    expect(s.type, "");
  });

  test("formatSpecifier(specifier) preserves unknown types", () {
    final s = FormatSpecifier.parse("q");
    expect(s.trim, false);
    expect(s.type, "q");
  });

  test("formatSpecifier(specifier) preserves shorthand", () {
    final s = FormatSpecifier.parse("");
    expect(s.trim, false);
    expect(s.type, "");
  });

  test("formatSpecifier(specifier).toString() reflects current field values",
      () {
    final s = FormatSpecifier.parse("");
    expect((s..fill = "_").toString(), "_>-");
    expect((s..align = "^").toString(), "_^-");
    expect((s..sign = "+").toString(), "_^+");
    expect((s..symbol = "\$").toString(), r"_^+$");
    expect((s..zero = true).toString(), r"_^+$0");
    expect((s..width = 12).toString(), r"_^+$012");
    expect((s..comma = true).toString(), r"_^+$012,");
    expect((s..precision = 2).toString(), r"_^+$012,.2");
    expect((s..type = "f").toString(), r"_^+$012,.2f");
    expect((s..trim = true).toString(), r"_^+$012,.2~f");
    expect(format(s.toString())(42), r"+$0,000,000,042");
  });

  test("formatSpecifier(specifier).toString() clamps precision to zero", () {
    final s = FormatSpecifier.parse("");
    expect((s..precision = -1).toString(), " >-.0");
  });

  test("formatSpecifier(specifier).toString() clamps width to one", () {
    final s = FormatSpecifier.parse("");
    expect((s..width = -1).toString(), " >-1");
  });

  test("new FormatSpecifier() has the expected defaults", () {
    final s = FormatSpecifier();
    expect(s.fill, " ");
    expect(s.align, ">");
    expect(s.sign, "-");
    expect(s.symbol, "");
    expect(s.zero, false);
    expect(s.width, null);
    expect(s.comma, false);
    expect(s.precision, null);
    expect(s.trim, false);
    expect(s.type, "");
  });
}
