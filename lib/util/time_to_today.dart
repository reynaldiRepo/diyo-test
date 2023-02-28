class TimeToToday {
  static DateTime? hourFormatToDate(String hourMinuteString) {
    DateTime now = DateTime.now();
    RegExp _timeRegExp = RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$');
    if (!_timeRegExp.hasMatch(hourMinuteString)) {
      return null;
    }
    var hour = int.parse(hourMinuteString.split(":")[0]);
    var minute = int.parse(hourMinuteString.split(":")[1]);

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }
}
