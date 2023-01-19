import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/monthly/grid_widget.dart';
import 'package:flutter_demo/widget/monthly/page_app_bar.dart' as Monthly;
import 'package:provider/provider.dart';

class MonthlyPage extends StatefulWidget {
  const MonthlyPage({Key? key}) : super(key: key);

  @override
  State<MonthlyPage> createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  late CalendarProvider? _calendarProvider;

  @override
  Widget build(BuildContext context) {
    _calendarProvider = Provider.of<CalendarProvider>(context);

    return Scaffold(
      appBar: Monthly.PageAppBar(DateTime.now()),
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
