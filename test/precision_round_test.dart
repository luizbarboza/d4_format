import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test("precisionRound(step, max) returns the expected value", () {
    expect(precisionRound(0.1, 1.1), 2); // "1.0", "1.1"
    expect(precisionRound(0.01, 0.99), 2); // "0.98", "0.99"
    expect(precisionRound(0.01, 1.00), 2); // "0.99", "1.0"
    expect(precisionRound(0.01, 1.01), 3); // "1.00", "1.01"
  });
}
