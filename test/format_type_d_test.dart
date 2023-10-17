import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"d\") can zero fill", () {
    final f = format("08d");
    expect(f(0), "00000000");
    expect(f(42), "00000042");
    expect(f(42000000), "42000000");
    expect(f(420000000), "420000000");
    expect(f(-4), "−0000004");
    expect(f(-42), "−0000042");
    expect(f(-4200000), "−4200000");
    expect(f(-42000000), "−42000000");
  });

  test("format(\"d\") can space fill", () {
    final f = format("8d");
    expect(f(0), "       0");
    expect(f(42), "      42");
    expect(f(42000000), "42000000");
    expect(f(420000000), "420000000");
    expect(f(-4), "      −4");
    expect(f(-42), "     −42");
    expect(f(-4200000), "−4200000");
    expect(f(-42000000), "−42000000");
  });

  test("format(\"d\") can underscore fill", () {
    final f = format("_>8d");
    expect(f(0), "_______0");
    expect(f(42), "______42");
    expect(f(42000000), "42000000");
    expect(f(420000000), "420000000");
    expect(f(-4), "______−4");
    expect(f(-42), "_____−42");
    expect(f(-4200000), "−4200000");
    expect(f(-42000000), "−42000000");
  });

  test("format(\"d\") can zero fill with sign and group", () {
    final f = format("+08,d");
    expect(f(0), "+0,000,000");
    expect(f(42), "+0,000,042");
    expect(f(42000000), "+42,000,000");
    expect(f(420000000), "+420,000,000");
    expect(f(-4), "−0,000,004");
    expect(f(-42), "−0,000,042");
    expect(f(-4200000), "−4,200,000");
    expect(f(-42000000), "−42,000,000");
  });

  test("format(\"d\") always uses zero precision", () {
    final f = format(".2d");
    expect(f(0), "0");
    expect(f(42), "42");
    expect(f(-4.2), "−4");
  });

  test("format(\"d\") rounds non-integers", () {
    final f = format("d");
    expect(f(4.2), "4");
  });

  test("format(\"0,d\") can group thousands and zero fill", () {
    expect(format("01,d")(0), "0");
    expect(format("01,d")(0), "0");
    expect(format("02,d")(0), "00");
    expect(format("03,d")(0), "000");
    expect(format("04,d")(0), "0,000");
    expect(format("05,d")(0), "0,000");
    expect(format("06,d")(0), "00,000");
    expect(format("08,d")(0), "0,000,000");
    expect(format("013,d")(0), "0,000,000,000");
    expect(format("021,d")(0), "0,000,000,000,000,000");
    expect(format("013,d")(-42000000), "−0,042,000,000");
    expect(format("012,d")(1e21), "1,000,000,000,000,000,000,000");
    expect(format("013,d")(1e21), "1,000,000,000,000,000,000,000");
    expect(format("014,d")(1e21), "1,000,000,000,000,000,000,000");
    expect(format("015,d")(1e21), "1,000,000,000,000,000,000,000");
  });

  test("format(\"0,d\") can group thousands and zero fill with overflow", () {
    expect(format("01,d")(1), "1");
    expect(format("01,d")(1), "1");
    expect(format("02,d")(12), "12");
    expect(format("03,d")(123), "123");
    expect(format("05,d")(12345), "12,345");
    expect(format("08,d")(12345678), "12,345,678");
    expect(format("013,d")(1234567890123), "1,234,567,890,123");
  });

  test("format(\",d\") can group thousands and space fill", () {
    expect(format("1,d")(0), "0");
    expect(format("1,d")(0), "0");
    expect(format("2,d")(0), " 0");
    expect(format("3,d")(0), "  0");
    expect(format("5,d")(0), "    0");
    expect(format("8,d")(0), "       0");
    expect(format("13,d")(0), "            0");
    expect(format("21,d")(0), "                    0");
  });

  test("format(\",d\") can group thousands and space fill with overflow", () {
    expect(format("1,d")(1), "1");
    expect(format("1,d")(1), "1");
    expect(format("2,d")(12), "12");
    expect(format("3,d")(123), "123");
    expect(format("5,d")(12345), "12,345");
    expect(format("8,d")(12345678), "12,345,678");
    expect(format("13,d")(1234567890123), "1,234,567,890,123");
  });

  test("format(\"<d\") align left", () {
    expect(format("<1,d")(0), "0");
    expect(format("<1,d")(0), "0");
    expect(format("<2,d")(0), "0 ");
    expect(format("<3,d")(0), "0  ");
    expect(format("<5,d")(0), "0    ");
    expect(format("<8,d")(0), "0       ");
    expect(format("<13,d")(0), "0            ");
    expect(format("<21,d")(0), "0                    ");
  });

  test("format(\">d\") align right", () {
    expect(format(">1,d")(0), "0");
    expect(format(">1,d")(0), "0");
    expect(format(">2,d")(0), " 0");
    expect(format(">3,d")(0), "  0");
    expect(format(">5,d")(0), "    0");
    expect(format(">8,d")(0), "       0");
    expect(format(">13,d")(0), "            0");
    expect(format(">21,d")(0), "                    0");
    expect(format(">21,d")(1000), "                1,000");
    expect(format(">21,d")(1e21), "1,000,000,000,000,000,000,000");
  });

  test("format(\"^d\") align center", () {
    expect(format("^1,d")(0), "0");
    expect(format("^1,d")(0), "0");
    expect(format("^2,d")(0), "0 ");
    expect(format("^3,d")(0), " 0 ");
    expect(format("^5,d")(0), "  0  ");
    expect(format("^8,d")(0), "   0    ");
    expect(format("^13,d")(0), "      0      ");
    expect(format("^21,d")(0), "          0          ");
    expect(format("^21,d")(1000), "        1,000        ");
    expect(format("^21,d")(1e21), "1,000,000,000,000,000,000,000");
  });

  test("format(\"=+,d\") pad after sign", () {
    expect(format("=+1,d")(0), "+0");
    expect(format("=+1,d")(0), "+0");
    expect(format("=+2,d")(0), "+0");
    expect(format("=+3,d")(0), "+ 0");
    expect(format("=+5,d")(0), "+   0");
    expect(format("=+8,d")(0), "+      0");
    expect(format("=+13,d")(0), "+           0");
    expect(format("=+21,d")(0), "+                   0");
    expect(format("=+21,d")(1e21), "+1,000,000,000,000,000,000,000");
  });

  test("format(\"=+\$,d\") pad after sign with currency", () {
    expect(format(r"=+$1,d")(0), r"+$0");
    expect(format(r"=+$1,d")(0), r"+$0");
    expect(format(r"=+$2,d")(0), r"+$0");
    expect(format(r"=+$3,d")(0), r"+$0");
    expect(format(r"=+$5,d")(0), r"+$  0");
    expect(format(r"=+$8,d")(0), r"+$     0");
    expect(format(r"=+$13,d")(0), r"+$          0");
    expect(format(r"=+$21,d")(0), r"+$                  0");
    expect(format(r"=+$21,d")(1e21), r"+$1,000,000,000,000,000,000,000");
  });

  test("format(\" ,d\") a space can denote positive numbers", () {
    expect(format(" 1,d")(-1), "−1");
    expect(format(" 1,d")(0), " 0");
    expect(format(" 2,d")(0), " 0");
    expect(format(" 3,d")(0), "  0");
    expect(format(" 5,d")(0), "    0");
    expect(format(" 8,d")(0), "       0");
    expect(format(" 13,d")(0), "            0");
    expect(format(" 21,d")(0), "                    0");
    expect(format(" 21,d")(1e21), " 1,000,000,000,000,000,000,000");
  });

  test("format(\"-,d\") explicitly only use a sign for negative numbers", () {
    expect(format("-1,d")(-1), "−1");
    expect(format("-1,d")(0), "0");
    expect(format("-2,d")(0), " 0");
    expect(format("-3,d")(0), "  0");
    expect(format("-5,d")(0), "    0");
    expect(format("-8,d")(0), "       0");
    expect(format("-13,d")(0), "            0");
    expect(format("-21,d")(0), "                    0");
  });

  test("format(\"d\") can format negative zero as zero", () {
    expect(format("1d")(-0), "0");
    expect(format("1d")(-1e-12), "0");
  });
}
