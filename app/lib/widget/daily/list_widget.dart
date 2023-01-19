import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/daily/list_cell.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    print("[ListWidget] initState");
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        if (_controller.position.maxScrollExtent == _controller.offset) {}
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("[ListWidget] build");

    return Scaffold(
        body: ListView.builder(
            itemCount: Constants.CALENDAR_LIST_CNT,
            itemBuilder: (context, index) {
              DateTime startDate = DateTime(2023, 1, 3, 0);
              final targetDate = startDate.add(Duration(hours: index));

              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(targetDate);
              List<Event>? events =
                  Provider.of<CalendarProvider>(context).events[formattedDate];
              double height = index == Constants.CALENDAR_LIST_CNT-1 ? 20 : 60;
              if (events != null) {
                return Center(child: ListCell(targetDate, height, events));
              }
              return Center(child: ListCell(targetDate, height, null));
            }));
  }
}
