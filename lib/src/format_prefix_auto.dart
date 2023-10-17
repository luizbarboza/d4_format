import 'dart:math';

import 'format_decimal.dart';

int? prefixExponent;

String formatPrefixAuto(num x, int p) {
  var d = formatDecimalParts(x, p);
  if (d == null) return x.toString();
  var coefficient = d.$1,
      exponent = d.$2,
      i = exponent -
          (prefixExponent = max(-8, min(8, (exponent / 3).floor())) * 3) +
          1,
      n = coefficient.length;
  return i == n
      ? coefficient
      : i > n
          ? coefficient + ("0" * (i - n))
          : i > 0
              ? "${coefficient.substring(0, i)}.${coefficient.substring(i)}"
              : "0.${"0" * i.abs()}${formatDecimalParts(x, max(0, p + i - 1))!.$1}"; // less than 1y!
}
