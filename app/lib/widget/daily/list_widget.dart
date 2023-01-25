import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/daily/list_cell.dart';
import 'package:flutter_demo/widget/daily/page_app_bar.dart' as Daily;
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListWidget extends StatefulWidget {
  final DateTime _dateTime;

  ListWidget(this._dateTime, {super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  late ScrollController _controller;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget._dateTime;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        if (_controller.position.maxScrollExtent == _controller.offset) {}
      }
    });
    _itemPositionsListener.itemPositions.addListener(() {
      // print("${_itemPositionsListener.itemPositions.value}");
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

    int currentTimeIndex = -1;
    double currentTimeOffset = -1;
    DateTime now = DateTime.now();
    if (_dateTime.year == now.year &&
        _dateTime.month == now.month &&
        _dateTime.day == now.day) {
      int seconds = now.second + now.minute * 60 + now.hour * 3600;
      currentTimeIndex = seconds ~/ 3600;
      currentTimeOffset = now.minute > 45 ? 10 : now.minute.toDouble() + 5;
      print("${currentTimeIndex}, ${seconds % 3600}");
    }
    return Scaffold(
        appBar: Daily.PageAppBar(_dateTime),
        body: ScrollablePositionedList.builder(
            itemCount: Constants.CALENDAR_LIST_CNT,
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            itemBuilder: (context, index) {
              DateTime startDate = _dateTime;
              final targetDate = startDate.add(Duration(hours: index));

              double nowOffset =
                  index == currentTimeIndex ? currentTimeOffset : 0;
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(targetDate);
              List<Event>? events =
                  Provider.of<CalendarProvider>(context).events[formattedDate];
              double height =
                  index == Constants.CALENDAR_LIST_CNT - 1 ? 20 : 60;
              if (events != null) {
                return Center(
                    child: ListCell(targetDate, nowOffset, height, events));
              }
              return Center(
                  child: ListCell(targetDate, nowOffset, height, null));
            }));
  }
}
