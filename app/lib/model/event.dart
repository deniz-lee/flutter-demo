// ignore_for_file: library_prefixes
import 'package:flutter_demo/tools/extentions.dart';
import 'package:googleapis/calendar/v3.dart' as Calendar;

class EventModel {
  final Calendar.Event event;
  final String? calendarId;
  final CalendarColorType? colorType;

  EventModel({
    required this.event,
    required this.calendarId,
    this.colorType,
  });

  parseToKST() {
    event.start?.dateTime = event.start?.dateTime?.toKST();
    event.start?.date = event.start?.date?.toKST();
    event.end?.dateTime = event.end?.dateTime?.toKST();
    event.end?.date = event.end?.date?.toKST();
  }
}
