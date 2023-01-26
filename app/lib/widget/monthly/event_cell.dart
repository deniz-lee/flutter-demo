import 'package:flutter/material.dart';
import 'package:flutter_demo/model/event.dart';

class EventCell extends StatelessWidget {
  final Event _event;

  const EventCell(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: const Color.fromARGB(170, 223, 201, 228),
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
            child: Text(
              _event.event.summary ?? "",
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Color.fromARGB(255, 131, 78, 151), fontSize: 12),
            ),
          )),
    );
  }
}
