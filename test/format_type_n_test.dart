import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"n\") is an alias for \",g\"", () {
    final f = format(".12n");
    expect(f(0), "0.00000000000");
    expect(f(42), "42.0000000000");
    expect(f(42000000), "42,000,000.0000");
    expect(f(420000000), "420,000,000.000");
    expect(f(-4), "−4.00000000000");
    expect(f(-42), "−42.0000000000");
    expect(f(-4200000), "−4,200,000.00000");
    expect(f(-42000000), "−42,000,000.0000");
    expect(f(.0042), "0.00420000000000");
    expect(f(.42), "0.420000000000");
    expect(f(1e21), "1.00000000000e+21");
  });

  test("format(\"n\") uses zero padding", () {
    expect(format("01.0n")(0), "0");
    expect(format("02.0n")(0), "00");
    expect(format("03.0n")(0), "000");
    expect(format("05.0n")(0), "0,000");
    expect(format("08.0n")(0), "0,000,000");
    expect(format("013.0n")(0), "0,000,000,000");
    expect(format("021.0n")(0), "0,000,000,000,000,000");
    expect(format("013.8n")(-42000000), "−0,042,000,000");
  });
}
