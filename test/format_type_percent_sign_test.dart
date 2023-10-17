import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("format(\"%\") can output a whole percentage", () {
    final f = format(".0%");
    expect(f(0), "0%");
    expect(f(0.042), "4%");
    expect(f(0.42), "42%");
    expect(f(4.2), "420%");
    expect(f(-.042), "−4%");
    expect(f(-.42), "−42%");
    expect(f(-4.2), "−420%");
  });

  test("format(\".%\") can output a percentage with precision", () {
    final f1 = format(".1%");
    expect(f1(0.234), "23.4%");
    final f2 = format(".2%");
    expect(f2(0.234), "23.40%");
  });

  test("format(\"%\") fill respects suffix", () {
    expect(format("020.0%")(42), "0000000000000004200%");
    expect(format("20.0%")(42), "               4200%");
  });

  test("format(\"^%\") align center puts suffix adjacent to number", () {
    expect(format("^21.0%")(0.42), "         42%         ");
    expect(format("^21,.0%")(422), "       42,200%       ");
    expect(format("^21,.0%")(-422), "      −42,200%       ");
  });
}
