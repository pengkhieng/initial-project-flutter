// ignore_for_file: omit_local_variable_types, prefer_final_locals
import 'dart:math';

import 'package:intl/intl.dart';

class StringHelper {
  static String formatTime(String time) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');
    final dateTime = inputFormat.parseStrict(time);
    return outputFormat.format(dateTime);
  }

  static String formatDate(String date) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
  }

  static String formatDateTime(String date) {
    return '${DateFormat('dd MMM yyyy').format(DateTime.parse(date))} ${DateFormat('hh:mm a').format(DateTime.parse(date))}';
  }

  static String getDurationBetweenTime(String dateTime) {
    final numberFormat = NumberFormat('00');
    DateTime initial = DateTime.parse(dateTime);
    int diffInSecond = DateTime.now().difference(initial).inSeconds;
    int second = diffInSecond % ~60;
    int minute = (diffInSecond ~/ 60) % ~60;
    int hour = diffInSecond ~/ 3600;
    return '${numberFormat.format(hour)}:${numberFormat.format(minute)}:${numberFormat.format(second)}';
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ['b', 'kb', 'mb', 'gb', 'tb'];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static String foratTimeDuration(Duration value) {
    String towDigits(int n) => n.toString().padLeft(2, '0');
    final hours = towDigits(value.inHours);
    final min = towDigits(value.inMinutes.remainder(60));
    final sec = towDigits(value.inSeconds.remainder(60));
    return [if (value.inHours > 0) hours, min, sec].join(":");
  }
}
