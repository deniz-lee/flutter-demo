import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'grid_cell.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  late int _length;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _length = Constants.CALENDAR_GRID_CNT;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        if (_controller.position.maxScrollExtent == _controller.offset) {
          setState(() {
            _length += Constants.CALENDAR_GRID_CNT;
          });
        }
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
    print("[GridWidget] build");

    return Scaffold(
      body: GridView.builder(
          controller: _controller,
          itemCount: _length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            DateTime startDate = DateTime(DateTime.now().year, 1, 1);
            final targetDate = startDate.add(Duration(days: index));
            String formattedDate = DateFormat('yyyy-MM-dd').format(targetDate);
            List<Event>? events =
                Provider.of<CalendarProvider>(context).events[formattedDate];
            if (events != null) {
              return Center(child: GridCell(targetDate, events));
            }
            return Center(child: GridCell(targetDate, null));
          }),
    );
  }

  Map<String, List<Event>?> reorderCalendarEventsByDateTime(
      List<Event> events) {
    Map<String, List<Event>?> result = {};
    for (Event event in events) {
      DateTime? startTime = event.start?.dateTime ?? event.start?.date;
      if (startTime == null) continue;

      String formattedDate = DateFormat('yyyy-MM-dd').format(startTime);
      List<Event>? events = result[formattedDate];
      if (events == null) {
        result[formattedDate] = [];
      }
      result[formattedDate]?.add(event);
    }
    return result;
  }
}
