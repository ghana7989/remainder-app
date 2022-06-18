import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int milliSecondsFromEpoch) {
  return DateFormat.yMMMMd()
      .format(
        DateTime.fromMillisecondsSinceEpoch(milliSecondsFromEpoch),
      )
      .toString();
}

String formatTime(BuildContext context, int hour, int minute) {
  return TimeOfDay(hour: hour, minute: minute).format(context).toString();
}
