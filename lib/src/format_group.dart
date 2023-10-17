import 'dart:math';

String Function(String, [int?]) formatGroup(
    List<int> grouping, String thousands) {
  return (value, [width]) {
    var i = value.length, t = <String>[], j = 0, g = grouping[0], length = 0;

    while (i > 0 && g > 0) {
      if (width != null && length + g + 1 > width) g = max(1, width - length);
      t.add(value.substring(max(0, i -= g), i + g));
      if (width != null && (length += g + 1) > width) break;
      g = grouping[j = (j + 1).remainder(grouping.length)];
    }

    return t.reversed.join(thousands);
  };
}
