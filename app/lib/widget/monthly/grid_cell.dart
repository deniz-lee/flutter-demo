import 'package:flutter/material.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/tools/extensions.dart';
import 'package:flutter_demo/widget/monthly/event_cell.dart';

typedef OnGridCellSizeChange = void Function(Size size);

class GridCell extends StatelessWidget {
  final DateTime? _dateTime;
  final List<EventModel>? _events;

  final OnGridCellSizeChange? _onChange;

  const GridCell(this._dateTime, this._events, this._onChange, {super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        Theme.of(context).colorScheme.primary;
    if (_dateTime?.weekday == DateTime.sunday) {
      textColor = CalendarColors.summary(context, CalendarColorType.red);
    }
    if (_dateTime?.weekday == DateTime.saturday) {
      textColor = CalendarColors.summary(context, CalendarColorType.blue);
    }
    List<Widget> children = [];
    List<Widget> stackChildren = [];

    DateTime now = DateTime.now();
    if (_dateTime?.year == now.year &&
        _dateTime?.month == now.month &&
        _dateTime?.day == now.day) {
      stackChildren.add(Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color:Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(20)),
      ));
    }

    stackChildren.add(Container(
      width: 15,
      margin: const EdgeInsets.only(left: 2.5, top: 2.5),
      alignment: Alignment.center,
      child: Text(
        _dateTime?.day.toString() ?? "",
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
    ));
    children.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 10, bottom: 5),
        child: Stack(children: stackChildren)));

    List<EventModel> events = _events ?? [];
    for (EventModel event in events) {
      EventCell cell = EventCell(event);
      children.add(cell);
    }

    return LayoutBuilder(builder: (context, constraints) {
      OnGridCellSizeChange? onChange = _onChange;
      if(onChange != null) {
        onChange(Size(constraints.maxWidth, constraints.maxHeight));
      }
      return DecoratedBox(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              )),
          child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              )));
    });
  }
}
