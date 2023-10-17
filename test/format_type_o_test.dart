import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"o\") octal", () {
    expect(format("o")(10), "12");
  });

  test("format(\"#o\") octal with prefix", () {
    expect(format("#o")(10), "0o12");
  });
}
