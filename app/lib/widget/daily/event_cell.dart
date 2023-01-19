import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as v3;

class EventCell extends StatelessWidget {
  final v3.Event _event;

  const EventCell(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
            child: Text(
              _event.summary ?? "",
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          )),
    );
  }
}
