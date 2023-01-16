import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/event_cell.dart';
import 'package:googleapis/calendar/v3.dart' as v3;

class GridCell extends StatelessWidget {
  final DateTime _dateTime;
  final List<v3.Event>? _events;

  const GridCell(this._dateTime, this._events, {super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (_dateTime.weekday == DateTime.sunday) textColor = Colors.redAccent;
    if (_dateTime.weekday == DateTime.saturday) textColor = Colors.blueAccent;

    List<Widget> children = [];
    children.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
        child: Text(
          _dateTime.day.toString(),
          style: TextStyle(color: textColor, fontSize: 10),
        )));

    List<v3.Event> events = _events ?? [];
    for (v3.Event event in events) {
      EventCell cell = EventCell(event);
      children.add(cell);
    }
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.1,
            )),
        child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            )));
  }
}
