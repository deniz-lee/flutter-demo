// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as Calendar;

class Event {
  late Calendar.Event event;
  late String? calendarId;
  late Color bgColor = Colors.black54;
  late Color textColor = Colors.white;

  Event({
    required this.event,
    required this.calendarId,
  });
}
