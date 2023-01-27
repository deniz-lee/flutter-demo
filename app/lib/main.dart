import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/screen/daily_page.dart';
import 'package:flutter_demo/screen/montly_page.dart';
import 'package:flutter_demo/themes/calendar_theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: CalendarThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CalendarEventColorScheme.light,
          ],
        ),
        darkTheme: CalendarThemeData.dark().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CalendarEventColorScheme.dark,
          ],
        ),
        home: ChangeNotifierProvider(
          create: (context) {
            return CalendarProvider(context);
          },
          child: OrientationBuilder(builder: (context, orientation) {
            var isLargeScreen = MediaQuery.of(context).size.width >
                responsiveWidthDivergingPoint_;
            return isLargeScreen ? const MonthlyPage() : const DailyPage();
          }),
        ));
  }
}
