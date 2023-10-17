import 'package:d4_format/d4_format.dart';
import 'package:test/test.dart';

void main() {
  test(
      "formatPrefix(\"s\", value)(number) formats with the SI prefix appropriate to the specified value",
      () {
    expect(formatPrefix(",.0s", 1e-6)(.00042), "420µ");
    expect(formatPrefix(",.0s", 1e-6)(.0042), "4,200µ");
    expect(formatPrefix(",.3s", 1e-3)(.00042), "0.420m");
  });

  test(
      "formatPrefix(\"s\", value)(number) uses yocto for very small reference values",
      () {
    expect(formatPrefix(",.0s", 1e-27)(1e-24), "1y");
  });

  test(
      "formatPrefix(\"s\", value)(number) uses yotta for very small reference values",
      () {
    expect(formatPrefix(",.0s", 1e27)(1e24), "1Y");
  });

  test(
      "formatPrefix(\"\$,s\", value)(number) formats with the specified SI prefix",
      () {
    final f = formatPrefix(r" $12,.1s", 1e6);
    expect(f(-42e6), r"      −$42.0M");
    expect(f(4.2e6), r"        $4.2M");
  });
}
