part of '../gestu_helper.dart';

extension DateTimeExtension on DateTime {
  String format({String format = 'dd-MM-yyyy kk:mm a', String locale = 'ES'}) {
    return DateFormat(format, locale).format(this);
  }

  DateTime setTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  TimeOfDay getTime() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime resetTime() {
    return DateTime(year, month, day);
  }

  DateTime lastTime() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTime firstDayOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime lastDayOfMonth() {
    return DateTime(year, month + 1, 0);
  }

  int getWeekOfMonth() {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysUntilDate = difference(firstDayOfMonth).inDays;
    return (daysUntilDate + firstDayOfMonth.weekday) ~/ DateTime.daysPerWeek;
  }

  int getWeekOfYear() {
    final startOfYear = DateTime(year, 1, 1);
    final days = difference(startOfYear).inDays;
    final daysInFirstWeek = startOfYear.weekday;
    return ((days + daysInFirstWeek - 1) ~/ DateTime.daysPerWeek) + 1;
  }
}
