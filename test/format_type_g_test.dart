import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"g\") can output general notation", () {
    expect(format(".1g")(0.049), "0.05");
    expect(format(".1g")(0.49), "0.5");
    expect(format(".2g")(0.449), "0.45");
    expect(format(".3g")(0.4449), "0.445");
    expect(format(".5g")(0.444449), "0.44445");
    expect(format(".1g")(100), "1e+2");
    expect(format(".2g")(100), "1.0e+2");
    expect(format(".3g")(100), "100");
    expect(format(".5g")(100), "100.00");
    expect(format(".5g")(100.2), "100.20");
    expect(format(".2g")(0.002), "0.0020");
  });

  test("format(\",g\") can group thousands with general notation", () {
    final f = format(",.12g");
    expect(f(0), "0.00000000000");
    expect(f(42), "42.0000000000");
    expect(f(42000000), "42,000,000.0000");
    expect(f(420000000), "420,000,000.000");
    expect(f(-4), "−4.00000000000");
    expect(f(-42), "−42.0000000000");
    expect(f(-4200000), "−4,200,000.00000");
    expect(f(-42000000), "−42,000,000.0000");
  });
}
