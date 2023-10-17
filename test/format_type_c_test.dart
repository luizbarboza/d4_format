import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"c\") unicode character", () {
    expect(format("c")("☃"), "☃");
    expect(format("020c")("☃"), "0000000000000000000☃");
    expect(format(" ^20c")("☃"), "         ☃          ");
    expect(format("\$c")("☃"), "\$☃");
  });

  test("format(\"c\") does not localize a decimal point", () {
    expect(FormatLocale(decimal: "/").format("c")("."), ".");
  });
}
