String formatDecimal(num x, [int? _]) {
  if (x < 1e21) return x.round().toString();

  final exponential = x.toString(),
      sign = exponential[0] == '-' ? '-' : '',
      parts = exponential.split("e"), //TODO: check index of "e"?
      coefficientParts = parts[0].replaceFirst("-", "").split('.'),
      exponent = int.parse(parts[1]);

  var whole = coefficientParts[0],
      fractional = coefficientParts.length > 1 ? coefficientParts[1] : "";

  final remainingFractional = fractional.length - exponent;
  return sign + whole + fractional + "0" * -remainingFractional;
}

// Computes the decimal coefficient and exponent of the specified number x with
// significant digits p, where x is positive and p is in [1, 21] or null.
// For example, formatDecimalParts(1.23) returns ["123", 0].
(String, int)? formatDecimalParts(num x, [int? p]) {
  int i;
  String string;
  if ((i = (string = p != null && p != 0
              ? x.toStringAsExponential(p - 1)
              : x.toStringAsExponential())
          .indexOf("e")) <
      0) return null; // NaN, ±Infinity
  String coefficient = string.substring(0, i);

  // The string returned by toExponential either has the form \d\.\d+e[-+]\d+
  // (e.g., 1.2e+3) or the form \de[-+]\d+ (e.g., 1e+3).
  return (
    coefficient.length > 1
        ? coefficient[0] + coefficient.substring(2)
        : coefficient,
    int.parse(string.substring(i + 1))
  );
}
