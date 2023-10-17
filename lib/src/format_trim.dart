// Trims insignificant zeros, e.g., replaces 1.2000k with 1.2k.
String formatTrim(String s) {
  num? p;
  int n = s.length, i = 1, i0 = -1, i1 = -1;
  out:
  for (; i < n; ++i) {
    switch (s[i]) {
      case ".":
        i0 = i1 = i;
        break;
      case "0":
        if (i0 == 0) i0 = i;
        i1 = i;
        break;
      default:
        if ((p = num.tryParse(s[i])) == null || p == 0) break out;
        if (i0 > 0) i0 = 0;
        break;
    }
  }
  return i0 > 0 ? s.substring(0, i0) + s.substring(i1 + 1) : s;
}
