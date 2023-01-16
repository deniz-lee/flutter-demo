import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/calendar_app_bar.dart';
import 'package:flutter_demo/widget/grid_widget.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarProvider? _calendarProvider;

  @override
  Widget build(BuildContext context) {
    _calendarProvider = Provider.of<CalendarProvider>(context);

    return Scaffold(
      appBar: CalendarAppBar(DateTime.now()),
      body: const GridWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.refresh_circled),
            onPressed: () {
              _calendarProvider?.update();
            },
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
