import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as v3;
import 'package:intl/intl.dart';

class EventCell extends StatelessWidget {
  final v3.Event _event;

  const EventCell(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? start = _event.start?.dateTime ?? _event.start?.date;
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
                    style: const TextStyle(color: Color.fromARGB(255, 131, 78, 151), fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    _event.summary ?? "",
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
