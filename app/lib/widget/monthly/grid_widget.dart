import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
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
    _length = monthlyItemCount_;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        if (_controller.position.maxScrollExtent == _controller.offset) {
          setState(() {
            _length += monthlyItemCount_;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            List<EventModel>? events =
                Provider.of<CalendarProvider>(context).events[formattedDate];
            if (events != null) {
              return Center(child: GridCell(targetDate, events));
            }
            return Center(child: GridCell(targetDate, null));
          }),
    );
  }
}
