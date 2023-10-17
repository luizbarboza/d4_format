import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"f\") can output fixed-point notation", () {
    expect(format(".1f")(0.49), "0.5");
    expect(format(".2f")(0.449), "0.45");
    expect(format(".3f")(0.4449), "0.445");
    expect(format(".5f")(0.444449), "0.44445");
    expect(format(".1f")(100), "100.0");
    expect(format(".2f")(100), "100.00");
    expect(format(".3f")(100), "100.000");
    expect(format(".5f")(100), "100.00000");
  });

  test("format(\"+\$,f\") can output a currency with comma-grouping and sign",
      () {
    final f = format(r"+$,.2f");
    expect(f(0), r"+$0.00");
    expect(f(0.429), r"+$0.43");
    expect(f(-0.429), r"−$0.43");
    expect(f(-1), r"−$1.00");
    expect(f(1e4), r"+$10,000.00");
  });

  test(
      "format(\",.f\") can group thousands, space fill, and round to significant digits",
      () {
    expect(format("10,.1f")(123456.49), " 123,456.5");
    expect(format("10,.2f")(1234567.449), "1,234,567.45");
    expect(format("10,.3f")(12345678.4449), "12,345,678.445");
    expect(format("10,.5f")(123456789.444449), "123,456,789.44445");
    expect(format("10,.1f")(123456), " 123,456.0");
    expect(format("10,.2f")(1234567), "1,234,567.00");
    expect(format("10,.3f")(12345678), "12,345,678.000");
    expect(format("10,.5f")(123456789), "123,456,789.00000");
  });

  test("format(\"f\") can display integers in fixed-point notation", () {
    expect(format("f")(42), "42.000000");
  });

  test("format(\"f\") can format negative zero as zero", () {
    expect(format("f")(-0), "0.000000");
    expect(format("f")(-1e-12), "0.000000");
  });

  test("format(\"+f\") signs negative zero correctly", () {
    expect(format("+f")(-0.0), "−0.000000");
    expect(format("+f")(0), "+0.000000");
    expect(format("+f")(-1e-12), "−0.000000");
    expect(format("+f")(1e-12), "+0.000000");
  });

  test("format(\"f\") can format negative infinity", () {
    expect(format("f")(double.negativeInfinity), "−Infinity");
  });

  test("format(\",f\") does not group Infinity", () {
    expect(format(",f")(double.infinity), "Infinity");
  });
}
