import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"b\") binary", () {
    expect(format("b")(10), "1010");
  });

  test("format(\"#b\") binary with prefix", () {
    expect(format("#b")(10), "0b1010");
  });
}
