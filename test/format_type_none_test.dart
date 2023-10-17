import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test(
      "format(\".[precision]\") uses significant precision and trims insignificant zeros",
      () {
    expect(format(".1")(4.9), "5");
    expect(format(".1")(0.49), "0.5");
    expect(format(".2")(4.9), "4.9");
    expect(format(".2")(0.49), "0.49");
    expect(format(".2")(0.449), "0.45");
    expect(format(".3")(4.9), "4.9");
    expect(format(".3")(0.49), "0.49");
    expect(format(".3")(0.449), "0.449");
    expect(format(".3")(0.4449), "0.445");
    expect(format(".5")(0.444449), "0.44445");
  });

  test("format(\".[precision]\") does not trim significant zeros", () {
    expect(format(".5")(10), "10");
    expect(format(".5")(100), "100");
    expect(format(".5")(1000), "1000");
    expect(format(".5")(21010), "21010");
    expect(format(".5")(1.10001), "1.1");
    expect(format(".5")(1.10001e6), "1.1e+6");
    expect(format(".6")(1.10001), "1.10001");
    expect(format(".6")(1.10001e6), "1.10001e+6");
  });

  test(
      "format(\".[precision]\") also trims the decimal point if there are only insignificant zeros",
      () {
    expect(format(".5")(1.00001), "1");
    expect(format(".5")(1.00001e6), "1e+6");
    expect(format(".6")(1.00001), "1.00001");
    expect(format(".6")(1.00001e6), "1.00001e+6");
  });

  test("format(\"\$\") can output a currency", () {
    final f = format(r"$");
    expect(f(0), r"$0");
    expect(f(.042), r"$0.042");
    expect(f(.42), r"$0.42");
    expect(f(4.2), r"$4.2");
    expect(f(-.042), r"−$0.042");
    expect(f(-.42), r"−$0.42");
    expect(f(-4.2), r"−$4.2");
  });

  test(
      "format(\"(\$\") can output a currency with parentheses for negative values",
      () {
    final f = format(r"($");
    expect(f(0), r"$0");
    expect(f(.042), r"$0.042");
    expect(f(.42), r"$0.42");
    expect(f(4.2), r"$4.2");
    expect(f(-.042), r"($0.042)");
    expect(f(-.42), r"($0.42)");
    expect(f(-4.2), r"($4.2)");
  });

  test("format(\"\") can format negative zero as zero", () {
    expect(format("")(-0), "0");
  });

  test("format(\"\") can format negative infinity", () {
    expect(format("")(double.negativeInfinity), "−Infinity");
  });
}
