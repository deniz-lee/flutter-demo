import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/daily/event_cell.dart';
import 'package:googleapis/calendar/v3.dart' as v3;
import 'package:intl/intl.dart';

class ListCell extends StatelessWidget {
  final DateTime _dateTime;
  final double _height;
  final double _nowOffset;
  final List<v3.Event>? _events;

  const ListCell(this._dateTime, this._nowOffset, this._height, this._events,
      {super.key});

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
      if (event.start?.date?.hour == _dateTime.hour) {
        EventCell cell = EventCell(event);
        children.add(cell);
      } else if (event.start?.dateTime?.hour == _dateTime.hour) {
        EventCell cell = EventCell(event);
        children.add(cell);
      }
    }

    List<Widget> stackChildren = [];
    stackChildren.add(Container(
        height: _height,
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        )));

    if (_nowOffset > 0) {
      stackChildren.add(nowTimeDivider(constraints, _nowOffset));
    }
    return Stack(children: stackChildren);
  }

  Widget nowTimeDivider(BoxConstraints constraints, double offset) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("h:mm").format(now);

    return Positioned(
        top: offset,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 35,
              margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
              child: Text(formattedDate,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: constraints.maxWidth - 55,
              height: 1.5,
              color: Colors.red,
            ),
          ],
        ));
  }

  Widget listDivider(BoxConstraints constraints, DateTime dateTime) {
    List<Widget> children = [];
    String formattedDate = DateFormat("h a").format(_dateTime);
    if (_nowOffset > 0 && _nowOffset < 15) {
      formattedDate = "";
    }
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
