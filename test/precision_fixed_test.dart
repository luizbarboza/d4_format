import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("precisionFixed(number) returns the expected value", () {
    expect(precisionFixed(8.9), 0);
    expect(precisionFixed(1.1), 0);
    expect(precisionFixed(0.89), 1);
    expect(precisionFixed(0.11), 1);
    expect(precisionFixed(0.089), 2);
    expect(precisionFixed(0.011), 2);
  });
}
