import 'format_decimal.dart';

String formatRounded(num x, int p) {
  var d = formatDecimalParts(x, p);
  if (d == null) return x.toString();
  var coefficient = d.$1, exponent = d.$2;
  return exponent < 0
      ? "0.${"0" * (-exponent - 1)}$coefficient"
      : coefficient.length > exponent + 1
          ? "${coefficient.substring(0, exponent + 1)}.${coefficient.substring(exponent + 1)}"
          : coefficient + ("0" * (exponent - coefficient.length + 1));
}
