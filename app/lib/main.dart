import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/screen/daily_page.dart';
import 'package:flutter_demo/screen/montly_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final DailyPage _dailyPage = DailyPage();
  final MonthlyPage _monthlyPage = MonthlyPage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) {
            return CalendarProvider(context);
          },
          child: OrientationBuilder(builder: (context, orientation) {
            var isLargeScreen = MediaQuery.of(context).size.width >
                Constants.RESPONSIVE_WIDTH_DIVERGING_POINT;
            return isLargeScreen ? _monthlyPage : _dailyPage;
          }),
        ));
  }
}
