import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/daily/event_cell.dart';
import 'package:flutter_demo/widget/daily/hourly_divider.dart';
import 'package:flutter_demo/widget/daily/page_app_bar.dart';
import 'package:flutter_demo/widget/daily/today_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScrollWidget extends StatefulWidget {
  final DateTime _dateTime;

  const ScrollWidget(this._dateTime, {super.key});

  @override
  State<ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  late DateTime _dateTime;
  final ScrollController _scrollController = ScrollController(
      initialScrollOffset: Static.dailyScrollOffset_,
      keepScrollOffset: true);

  @override
  void initState() {
    _dateTime = widget._dateTime;
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        Static.dailyScrollOffset_ = _scrollController.offset;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget layoutBuilder = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      List<Widget> children = [];
      _addHourlyDivider(constraints, _dateTime, children);
      _addEventsIfNeeded(constraints, _dateTime, children);
      _addIndicator(constraints, DateTime.now(), children);

      return Stack(children: children);
    });
    Widget scrollView = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        child: layoutBuilder);
    return Scaffold(appBar: PageAppBar(_dateTime), body: scrollView);
  }
}

extension _EventExtension on _ScrollWidgetState {
  _addEventsIfNeeded(
      BoxConstraints constraints, DateTime startDate, List<Widget> parent) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(startDate);
    List<EventModel>? events =
        Provider.of<CalendarProvider>(context).events[formattedDate];
    if (events == null) return;

    for (int i = 0; i < events.length; i++) {
      EventModel event = events[i];
      Widget? eventCell = _eventCell(constraints, event);
      if (eventCell == null) continue;
      parent.add(eventCell);
    }
  }

  Widget? _eventCell(BoxConstraints constraints, EventModel event) {
    DateTime? start = event.event.start?.dateTime ?? event.event.start?.date;
    DateTime? end = event.event.end?.dateTime ?? event.event.end?.date;
    if (start == null) return null;
    if (end == null) return null;

    int top = start.hour * Duration.minutesPerHour + start.minute + 10;
    int bottom = end.hour * Duration.minutesPerHour + end.minute + 10;
    int height = bottom - top;

    return Positioned(
        top: top.toDouble(),
        left: 45,
        width: constraints.maxWidth - 45,
        height: height.toDouble(),
        child: EventCell(event));
  }
}

extension _IndicatorExtension on _ScrollWidgetState {
  _addIndicator(
      BoxConstraints constraints, DateTime startDate, List<Widget> parent) {
    int offset =
        startDate.hour * Duration.minutesPerHour + startDate.minute + 5;
    Widget indicator = Positioned(
      top: offset.toDouble(),
      child: TodayIndicator(constraints),
    );
    parent.add(indicator);
  }
}

extension _DividerExtension on _ScrollWidgetState {
  _addHourlyDivider(
      BoxConstraints constraints, DateTime startDate, List<Widget> parent) {
    List<Widget> children = [];
    for (int i = 0; i < dailyItemCount_; i++) {
      final targetDate = startDate.add(Duration(hours: i));
      double height = i < dailyItemCount_ - 1
          ? dailyItemHeight_
          : 20;
      Widget widget = HourlyDivider(constraints, targetDate, height);
      children.add(widget);
    }
    Widget column = Column(children: children);
    parent.add(column);
  }
}
