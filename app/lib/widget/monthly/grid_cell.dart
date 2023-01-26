import 'package:flutter/material.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/widget/monthly/event_cell.dart';

class GridCell extends StatelessWidget {
  final DateTime _dateTime;
  final List<Event>? _events;

  const GridCell(this._dateTime, this._events, {super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (_dateTime.weekday == DateTime.sunday) textColor = Colors.redAccent;
    if (_dateTime.weekday == DateTime.saturday) textColor = Colors.blueAccent;

    List<Widget> children = [];
    List<Widget> stackChildren = [];

    DateTime now = DateTime.now();
    if (_dateTime.year == now.year &&
        _dateTime.month == now.month &&
        _dateTime.day == now.day) {
      stackChildren.add(Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(20)),
      ));
    }

    stackChildren.add(Container(
      width: 15,
      margin: const EdgeInsets.fromLTRB(2.5, 2.5, 0, 0),
      alignment: Alignment.center,
      child: Text(
        _dateTime.day.toString(),
        style: TextStyle(color: textColor, fontSize: 10),
      ),
    ));
    children.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
        child: Stack(children: stackChildren)));

    List<Event> events = _events ?? [];
    for (Event event in events) {
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
