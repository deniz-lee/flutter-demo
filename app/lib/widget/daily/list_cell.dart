import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/daily/event_cell.dart';
import 'package:googleapis/calendar/v3.dart' as v3;
import 'package:intl/intl.dart';

class ListCell extends StatelessWidget {
  final DateTime _dateTime;
  double _height = 0;
  final List<v3.Event>? _events;

  ListCell(this._dateTime, this._height, this._events, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget layoutBuilder = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return listCell(constraints, _dateTime);
    });
    return layoutBuilder;
  }

  Widget listCell(BoxConstraints constraints, DateTime dateTime) {
    List<Widget> children = [];
    children.add(listDivider(constraints, _dateTime));

    List<v3.Event> events = _events ?? [];
    for (v3.Event event in events) {
      if (event.start?.dateTime?.hour != _dateTime.hour) continue;
      EventCell cell = EventCell(event);
      children.add(cell);
    }
    return Container(
        height: _height,
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ));
  }

  Widget listDivider(BoxConstraints constraints, DateTime dateTime) {
    List<Widget> children = [];
    String formattedDate = DateFormat("h a").format(_dateTime);
    children.add(Container(
      width: 30,
      margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Text(formattedDate,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 10, color: Colors.black38)),
    ));
    children.add(Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      height: 1,
      width: constraints.maxWidth - 60,
      color: Colors.black12,
    ));
    return Container(
      child: Row(
        children: children,
      ),
    );
  }
}
