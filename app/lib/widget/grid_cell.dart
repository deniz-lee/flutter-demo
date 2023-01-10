import 'package:flutter/material.dart';

class GridCell extends StatelessWidget {
  final DateTime _dateTime;

  const GridCell(this._dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (_dateTime.weekday == DateTime.sunday) textColor = Colors.red;
    if (_dateTime.weekday == DateTime.saturday) textColor = Colors.blue;

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.1,
            )),
        child: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            _dateTime.day.toString(),
            style: TextStyle(color: textColor, fontSize: 10),
          ),
        ));
  }
}
