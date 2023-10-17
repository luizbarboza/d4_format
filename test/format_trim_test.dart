import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"~r\") trims insignificant zeros", () {
    final f = format("~r");
    expect(f(1), "1");
    expect(f(0.1), "0.1");
    expect(f(0.01), "0.01");
    expect(f(10.0001), "10.0001");
    expect(f(123.45), "123.45");
    expect(f(123.456), "123.456");
    expect(f(123.4567), "123.457");
    expect(f(0.000009), "0.000009");
    expect(f(0.0000009), "0.0000009");
    expect(f(0.00000009), "0.00000009");
    expect(f(0.111119), "0.111119");
    expect(f(0.1111119), "0.111112");
    expect(f(0.11111119), "0.111111");
  });

  test("format(\"~e\") trims insignificant zeros", () {
    final f = format("~e");
    expect(f(0), "0e+0");
    expect(f(42), "4.2e+1");
    expect(f(42000000), "4.2e+7");
    expect(f(0.042), "4.2e-2");
    expect(f(-4), "−4e+0");
    expect(f(-42), "−4.2e+1");
    expect(f(42000000000), "4.2e+10");
    expect(f(0.00000000042), "4.2e-10");
  });

  test("format(\".4~e\") trims insignificant zeros", () {
    final f = format(".4~e");
    expect(f(0.00000000012345), "1.2345e-10");
    expect(f(0.00000000012340), "1.234e-10");
    expect(f(0.00000000012300), "1.23e-10");
    expect(f(-0.00000000012345), "−1.2345e-10");
    expect(f(-0.00000000012340), "−1.234e-10");
    expect(f(-0.00000000012300), "−1.23e-10");
    expect(f(12345000000), "1.2345e+10");
    expect(f(12340000000), "1.234e+10");
    expect(f(12300000000), "1.23e+10");
    expect(f(-12345000000), "−1.2345e+10");
    expect(f(-12340000000), "−1.234e+10");
    expect(f(-12300000000), "−1.23e+10");
  });

  test("format(\"~s\") trims insignificant zeros", () {
    final f = format("~s");
    expect(f(0), "0");
    expect(f(1), "1");
    expect(f(10), "10");
    expect(f(100), "100");
    expect(f(999.5), "999.5");
    expect(f(999500), "999.5k");
    expect(f(1000), "1k");
    expect(f(1400), "1.4k");
    expect(f(1500), "1.5k");
    expect(f(1500.5), "1.5005k");
    expect(f(1e-15), "1f");
    expect(f(1e-12), "1p");
    expect(f(1e-9), "1n");
    expect(f(1e-6), "1µ");
    expect(f(1e-3), "1m");
    expect(f(1e0), "1");
    expect(f(1e3), "1k");
    expect(f(1e6), "1M");
    expect(f(1e9), "1G");
    expect(f(1e12), "1T");
    expect(f(1e15), "1P");
  });

  test("format(\"~%\") trims insignificant zeros", () {
    final f = format("~%");
    expect(f(0), "0%");
    expect(f(0.1), "10%");
    expect(f(0.01), "1%");
    expect(f(0.001), "0.1%");
    expect(f(0.0001), "0.01%");
  });

  test("trimming respects commas", () {
    final f = format(",~g");
    expect(f(10000.0), "10,000");
    expect(f(10000.1), "10,000.1");
  });
}
