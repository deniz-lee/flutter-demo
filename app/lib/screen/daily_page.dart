import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/daily/list_widget.dart';
import 'package:flutter_demo/widget/daily/page_app_bar.dart' as Daily;
import 'package:provider/provider.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  late CalendarProvider? _calendarProvider;

  @override
  Widget build(BuildContext context) {
    _calendarProvider = Provider.of<CalendarProvider>(context);

    return Scaffold(
      appBar: Daily.PageAppBar(DateTime.now()),
      body: const ListWidget(),
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
      ),
    );
  }
}
