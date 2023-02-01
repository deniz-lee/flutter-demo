import 'package:flutter/material.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/tools/extensions.dart';

class EventCell extends StatelessWidget {
  final EventModel _event;

  const EventCell(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: CalendarColors.background(context, _event.colorType),
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
            child: Text(
              _event.event.summary ?? "",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: CalendarColors.title(context, _event.colorType),
                  fontSize: 12),
            ),
          )),
    );
  }
}
