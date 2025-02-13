class DateUtils {
  static DateTime parseApiDate(String? dateString) {
    if (dateString == null) return DateTime(1970, 1, 1);

    final match = RegExp(r"\/Date\((\d+)[+-]\d+\)\/").firstMatch(dateString);
    if (match != null) {
      return DateTime.fromMillisecondsSinceEpoch(int.parse(match.group(1)!));
    }

    return DateTime(1970, 1, 1);
  }
}
