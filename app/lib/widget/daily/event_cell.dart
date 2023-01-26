import 'package:flutter/material.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:intl/intl.dart';

class EventCell extends StatelessWidget {
  final Event _event;

  const EventCell(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? start = _event.event.start?.dateTime ?? _event.event.start?.date;
    String? formattedDate;
    if (start != null) {
      formattedDate = DateFormat("h:mm a").format(start);
    }
    return Container(
      height: 20,
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: const Color.fromARGB(170, 223, 201, 228),
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    formattedDate ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 131, 78, 151), fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    _event.event.summary ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 131, 78, 151),
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
