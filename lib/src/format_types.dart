import 'format_decimal.dart';
import 'format_prefix_auto.dart';
import 'format_rounded.dart';

final formatTypes = <String, String Function(num, int)>{
  "%": (x, p) => (x * 100).toStringAsFixed(p),
  "b": (x, [int? _]) => x.round().toRadixString(2),
  "c": (x, [int? _]) => x.toString(),
  "d": formatDecimal,
  "e": (x, p) => x.toStringAsExponential(p),
  "f": (x, p) => x.toStringAsFixed(p),
  "g": (x, p) => x.toStringAsPrecision(p),
  "o": (x, [int? _]) => x.round().toRadixString(8),
  "p": (x, p) => formatRounded(x * 100, p),
  "r": formatRounded,
  "s": formatPrefixAuto,
  "X": (x, [int? _]) => x.round().toRadixString(16).toUpperCase(),
  "x": (x, [int? _]) => x.round().toRadixString(16)
};
