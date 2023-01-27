import 'package:flutter/material.dart';
import 'package:flutter_demo/themes/calendar_theme_data.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

extension TimeZoneExtension on DateTime {
  DateTime toKST() {
    tz.initializeTimeZones();
    final kstTimeZone = tz.getLocation('Asia/Seoul');
    return tz.TZDateTime.from(this, kstTimeZone);
  }
}

enum CalendarColorType { blue, orange, green, yellow, red }

extension CalendarColors on Colors {
  static Color background(BuildContext context, CalendarColorType? type) {
    final customColors =
        Theme.of(context).extension<CalendarEventColorScheme>();
    Color defaultColor = Colors.black38;
    if (type == CalendarColorType.red) {
      return customColors?.redBackgroundColor ?? defaultColor;
    }
    if (type == CalendarColorType.orange) {
      return customColors?.orangeBackgroundColor ?? defaultColor;
    }
    if (type == CalendarColorType.yellow) {
      return customColors?.yellowBackgroundColor ?? defaultColor;
    }
    if (type == CalendarColorType.green) {
      return customColors?.greenBackgroundColor ?? defaultColor;
    }
    if (type == CalendarColorType.blue) {
      return customColors?.blueBackgroundColor ?? defaultColor;
    }
    return defaultColor;
  }

  static Color title(BuildContext context, CalendarColorType? type) {
    final customColors =
        Theme.of(context).extension<CalendarEventColorScheme>();
    Color defaultColor = Colors.white;
    if (type == CalendarColorType.red) {
      return customColors?.redTitleColor ?? defaultColor;
    }
    if (type == CalendarColorType.orange) {
      return customColors?.orangeTitleColor ?? defaultColor;
    }
    if (type == CalendarColorType.yellow) {
      return customColors?.yellowTitleColor ?? defaultColor;
    }
    if (type == CalendarColorType.green) {
      return customColors?.greenTitleColor ?? defaultColor;
    }
    if (type == CalendarColorType.blue) {
      return customColors?.blueTitleColor ?? defaultColor;
    }
    return defaultColor;
  }

  static Color summary(BuildContext context, CalendarColorType? type) {
    final customColors =
        Theme.of(context).extension<CalendarEventColorScheme>();
    Color defaultColor = Colors.white;
    if (type == CalendarColorType.red) {
      return customColors?.redSummaryColor ?? defaultColor;
    }
    if (type == CalendarColorType.orange) {
      return customColors?.orangeSummaryColor ?? defaultColor;
    }
    if (type == CalendarColorType.yellow) {
      return customColors?.yellowSummaryColor ?? defaultColor;
    }
    if (type == CalendarColorType.green) {
      return customColors?.greenSummaryColor ?? defaultColor;
    }
    if (type == CalendarColorType.blue) {
      return customColors?.blueSummaryColor ?? defaultColor;
    }
    return defaultColor;
  }
}
