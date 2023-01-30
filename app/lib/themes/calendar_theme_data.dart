import 'package:flutter/material.dart';

class CalendarThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData light() {
    return themeData(lightColorScheme, _lightFocusColor);
  }

  static ThemeData dark() {
    return themeData(darkColorScheme, _darkFocusColor);
  }

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      textTheme: Typography(platform: TargetPlatform.iOS).englishLike,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.secondaryContainer,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: TextStyle(color: colorScheme.secondary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: colorScheme.surfaceTint,
      focusColor: focusColor,
      indicatorColor: colorScheme.surfaceTint,
      dividerColor: colorScheme.shadow,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xff272727),
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff272727),
    secondaryContainer: Color(0xfff5f5f5),
    background: Color(0xffffffff),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
    surfaceTint: Color(0xffffc842),
    shadow: Color(0xffdbdbdb),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xffdfdddd),
    primaryContainer: Color(0xff2d221e),
    secondary: Color(0xffdfdddd),
    secondaryContainer: Color(0xff312a28),
    background: Color(0xff2d221e),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
    surfaceTint: Color(0xffce912c),
    shadow: Color(0xff615957),
  );
}

enum ColorType { red, orange, yellow, green, blue, purple, brown }

@immutable
class CalendarEventColorScheme
    extends ThemeExtension<CalendarEventColorScheme> {
  const CalendarEventColorScheme({
    required this.redBackgroundColor,
    required this.redTitleColor,
    required this.redSummaryColor,
    required this.orangeBackgroundColor,
    required this.orangeTitleColor,
    required this.orangeSummaryColor,
    required this.yellowBackgroundColor,
    required this.yellowTitleColor,
    required this.yellowSummaryColor,
    required this.greenBackgroundColor,
    required this.greenTitleColor,
    required this.greenSummaryColor,
    required this.blueBackgroundColor,
    required this.blueTitleColor,
    required this.blueSummaryColor,
  });

  final Color? redBackgroundColor;
  final Color? redTitleColor;
  final Color? redSummaryColor;
  final Color? orangeBackgroundColor;
  final Color? orangeTitleColor;
  final Color? orangeSummaryColor;
  final Color? yellowBackgroundColor;
  final Color? yellowTitleColor;
  final Color? yellowSummaryColor;
  final Color? greenBackgroundColor;
  final Color? greenTitleColor;
  final Color? greenSummaryColor;
  final Color? blueBackgroundColor;
  final Color? blueTitleColor;
  final Color? blueSummaryColor;

  @override
  CalendarEventColorScheme copyWith({
    Color? redBackgroundColor,
    Color? redTitleColor,
    Color? redSummaryColor,
    Color? orangeBackgroundColor,
    Color? orangeTitleColor,
    Color? orangeSummaryColor,
    Color? yellowBackgroundColor,
    Color? yellowTitleColor,
    Color? yellowSummaryColor,
    Color? greenBackgroundColor,
    Color? greenTitleColor,
    Color? greenSummaryColor,
    Color? blueBackgroundColor,
    Color? blueTitleColor,
    Color? blueSummaryColor,
  }) {
    return CalendarEventColorScheme(
      redBackgroundColor: redBackgroundColor,
      redTitleColor: redTitleColor,
      redSummaryColor: redSummaryColor,
      orangeBackgroundColor: orangeBackgroundColor,
      orangeTitleColor: orangeTitleColor,
      orangeSummaryColor: orangeSummaryColor,
      yellowBackgroundColor: yellowBackgroundColor,
      yellowTitleColor: yellowTitleColor,
      yellowSummaryColor: yellowSummaryColor,
      greenBackgroundColor: greenBackgroundColor,
      greenTitleColor: greenTitleColor,
      greenSummaryColor: greenSummaryColor,
      blueBackgroundColor: blueBackgroundColor,
      blueTitleColor: blueTitleColor,
      blueSummaryColor: blueSummaryColor,
    );
  }

  @override
  CalendarEventColorScheme lerp(
      ThemeExtension<CalendarEventColorScheme>? other, double t) {
    if (other is! CalendarEventColorScheme) {
      return this;
    }
    return CalendarEventColorScheme(
      redBackgroundColor:
          Color.lerp(redBackgroundColor, other.redBackgroundColor, t),
      redTitleColor: Color.lerp(redTitleColor, other.redTitleColor, t),
      redSummaryColor: Color.lerp(redSummaryColor, other.redSummaryColor, t),
      orangeBackgroundColor:
          Color.lerp(orangeBackgroundColor, other.orangeBackgroundColor, t),
      orangeTitleColor: Color.lerp(orangeTitleColor, other.orangeTitleColor, t),
      orangeSummaryColor:
          Color.lerp(yellowSummaryColor, other.yellowSummaryColor, t),
      yellowBackgroundColor:
          Color.lerp(orangeBackgroundColor, other.orangeBackgroundColor, t),
      yellowTitleColor: Color.lerp(yellowTitleColor, other.yellowTitleColor, t),
      yellowSummaryColor:
          Color.lerp(yellowSummaryColor, other.yellowSummaryColor, t),
      greenBackgroundColor:
          Color.lerp(greenBackgroundColor, other.greenBackgroundColor, t),
      greenTitleColor: Color.lerp(greenTitleColor, other.greenTitleColor, t),
      greenSummaryColor:
          Color.lerp(greenSummaryColor, other.greenSummaryColor, t),
      blueBackgroundColor:
          Color.lerp(blueBackgroundColor, other.blueBackgroundColor, t),
      blueTitleColor: Color.lerp(blueTitleColor, other.blueTitleColor, t),
      blueSummaryColor: Color.lerp(blueSummaryColor, other.blueSummaryColor, t),
    );
  }

  static const light = CalendarEventColorScheme(
    redBackgroundColor: Color(0xffffccda),
    redTitleColor: Color(0xffc92c55),
    redSummaryColor: Color(0xfffa2956),
    orangeBackgroundColor: Color(0xffffe2cf),
    orangeTitleColor: Color(0xffb5641d),
    orangeSummaryColor: Color(0xfff6800b),
    yellowBackgroundColor: Color(0xfffef1ce),
    yellowTitleColor: Color(0xffa58012),
    yellowSummaryColor: Color(0xfff9bf09),
    greenBackgroundColor: Color(0xffdbf6d3),
    greenTitleColor: Color(0xff4c922c),
    greenSummaryColor: Color(0xff53d12a),
    blueBackgroundColor: Color(0xffd2ebfe),
    blueTitleColor: Color(0xff217eb1),
    blueSummaryColor: Color(0xff1ba5ee),
  );

  static const dark = CalendarEventColorScheme(
    redBackgroundColor: Color(0xff55252a),
    redTitleColor: Color(0xffeb2f78),
    redSummaryColor: Color(0xffd82b70),
    orangeBackgroundColor: Color(0xff543620),
    orangeTitleColor: Color(0xffeb8902),
    orangeSummaryColor: Color(0xffee8a00),
    yellowBackgroundColor: Color(0xff574423),
    yellowTitleColor: Color(0xffefc90a),
    yellowSummaryColor: Color(0xffecc60a),
    greenBackgroundColor: Color(0xff334326),
    greenTitleColor: Color(0xff32d74b),
    greenSummaryColor: Color(0xff2fc746),
    blueBackgroundColor: Color(0xff2f3a4a),
    blueTitleColor: Color(0xff1aadf8),
    blueSummaryColor: Color(0xff1a9fe6),
  );
}
