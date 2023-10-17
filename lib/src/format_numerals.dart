String Function(String) formatNumerals(List<String> numerals) {
  final exp = RegExp(r'[0-9]');
  return (value) {
    return value.replaceAllMapped(
        exp, (match) => numerals[int.parse(match[0]!)]);
  };
}
