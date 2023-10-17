import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"s\") outputs SI-prefix notation with default precision 6", () {
    final f = format("s");
    expect(f(0), "0.00000");
    expect(f(1), "1.00000");
    expect(f(10), "10.0000");
    expect(f(100), "100.000");
    expect(f(999.5), "999.500");
    expect(f(999500), "999.500k");
    expect(f(1000), "1.00000k");
    expect(f(100), "100.000");
    expect(f(1400), "1.40000k");
    expect(f(1500.5), "1.50050k");
    expect(f(.00001), "10.0000µ");
    expect(f(.000001), "1.00000µ");
  });

  test(
      "format(\"[.precision]s\") outputs SI-prefix notation with precision significant digits",
      () {
    final f1 = format(".3s");
    expect(f1(0), "0.00");
    expect(f1(1), "1.00");
    expect(f1(10), "10.0");
    expect(f1(100), "100");
    expect(f1(999.5), "1.00k");
    expect(f1(999500), "1.00M");
    expect(f1(1000), "1.00k");
    expect(f1(1500.5), "1.50k");
    expect(f1(145500000), "146M");
    expect(f1(145999999.99999347), "146M");
    expect(f1(1e26), "100Y");
    expect(f1(.000001), "1.00µ");
    expect(f1(.009995), "10.0m");
    final f2 = format(".4s");
    expect(f2(999.5), "999.5");
    expect(f2(999500), "999.5k");
    expect(f2(.009995), "9.995m");
  });

  test("format(\"s\") formats numbers smaller than 1e-24 with yocto", () {
    final f = format(".8s");
    expect(f(1.29e-30), "0.0000013y"); // Note: rounded!
    expect(f(1.29e-29), "0.0000129y");
    expect(f(1.29e-28), "0.0001290y");
    expect(f(1.29e-27), "0.0012900y");
    expect(f(1.29e-26), "0.0129000y");
    expect(f(1.29e-25), "0.1290000y");
    expect(f(1.29e-24), "1.2900000y");
    expect(f(1.29e-23), "12.900000y");
    expect(f(1.29e-22), "129.00000y");
    expect(f(1.29e-21), "1.2900000z");
    expect(f(-1.29e-30), "−0.0000013y"); // Note: rounded!
    expect(f(-1.29e-29), "−0.0000129y");
    expect(f(-1.29e-28), "−0.0001290y");
    expect(f(-1.29e-27), "−0.0012900y");
    expect(f(-1.29e-26), "−0.0129000y");
    expect(f(-1.29e-25), "−0.1290000y");
    expect(f(-1.29e-24), "−1.2900000y");
    expect(f(-1.29e-23), "−12.900000y");
    expect(f(-1.29e-22), "−129.00000y");
    expect(f(-1.29e-21), "−1.2900000z");
  });

  test("format(\"s\") formats numbers larger than 1e24 with yotta", () {
    final f = format(".8s");
    expect(f(1.23e+21), "1.2300000Z");
    expect(f(1.23e+22), "12.300000Z");
    expect(f(1.23e+23), "123.00000Z");
    expect(f(1.23e+24), "1.2300000Y");
    expect(f(1.23e+25), "12.300000Y");
    expect(f(1.23e+26), "123.00000Y");
    expect(f(1.23e+27), "1230.0000Y");
    expect(f(1.23e+28), "12300.000Y");
    expect(f(1.23e+29), "123000.00Y");
    expect(f(1.23e+30), "1230000.0Y");
    expect(f(-1.23e+21), "−1.2300000Z");
    expect(f(-1.23e+22), "−12.300000Z");
    expect(f(-1.23e+23), "−123.00000Z");
    expect(f(-1.23e+24), "−1.2300000Y");
    expect(f(-1.23e+25), "−12.300000Y");
    expect(f(-1.23e+26), "−123.00000Y");
    expect(f(-1.23e+27), "−1230.0000Y");
    expect(f(-1.23e+28), "−12300.000Y");
    expect(f(-1.23e+29), "−123000.00Y");
    expect(f(-1.23e+30), "−1230000.0Y");
  });

  test("format(\"\$s\") outputs SI-prefix notation with a currency symbol", () {
    final f1 = format(r"$.2s");
    expect(f1(0), r"$0.0");
    expect(f1(2.5e5), r"$250k");
    expect(f1(-2.5e8), r"−$250M");
    expect(f1(2.5e11), r"$250G");
    final f2 = format(r"$.3s");
    expect(f2(0), r"$0.00");
    expect(f2(1), r"$1.00");
    expect(f2(10), r"$10.0");
    expect(f2(100), r"$100");
    expect(f2(999.5), r"$1.00k");
    expect(f2(999500), r"$1.00M");
    expect(f2(1000), r"$1.00k");
    expect(f2(1500.5), r"$1.50k");
    expect(f2(145500000), r"$146M");
    expect(f2(145999999.9999347), r"$146M");
    expect(f2(1e26), r"$100Y");
    expect(f2(.000001), r"$1.00µ");
    expect(f2(.009995), r"$10.0m");
    final f3 = format(r"$.4s");
    expect(f3(999.5), r"$999.5");
    expect(f3(999500), r"$999.5k");
    expect(f3(.009995), r"$9.995m");
  });

  test(
      "format(\"s\") SI-prefix notation precision is consistent for small and large numbers",
      () {
    final f1 = format(".0s");
    expect(f1(1e-5), "10µ");
    expect(f1(1e-4), "100µ");
    expect(f1(1e-3), "1m");
    expect(f1(1e-2), "10m");
    expect(f1(1e-1), "100m");
    expect(f1(1e+0), "1");
    expect(f1(1e+1), "10");
    expect(f1(1e+2), "100");
    expect(f1(1e+3), "1k");
    expect(f1(1e+4), "10k");
    expect(f1(1e+5), "100k");
    final f2 = format(".4s");
    expect(f2(1e-5), "10.00µ");
    expect(f2(1e-4), "100.0µ");
    expect(f2(1e-3), "1.000m");
    expect(f2(1e-2), "10.00m");
    expect(f2(1e-1), "100.0m");
    expect(f2(1e+0), "1.000");
    expect(f2(1e+1), "10.00");
    expect(f2(1e+2), "100.0");
    expect(f2(1e+3), "1.000k");
    expect(f2(1e+4), "10.00k");
    expect(f2(1e+5), "100.0k");
  });

  test("format(\"0[width],s\") will group thousands due to zero fill", () {
    final f = format("020,s");
    expect(f(42), "000,000,000,042.0000");
    expect(f(42e12), "00,000,000,042.0000T");
  });

  test("format(\",s\") will group thousands for very large numbers", () {
    final f = format(",s");
    expect(f(42e30), "42,000,000Y");
  });
}
