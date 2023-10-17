import 'format_decimal.dart';

int? exponent(num x) {
  var p = formatDecimalParts(x.abs());
  return p?.$2;
}
