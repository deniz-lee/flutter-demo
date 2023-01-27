import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyDivider extends StatelessWidget {
  final BoxConstraints _constraints;
  final DateTime _dateTime;
  final double _height;

  const HourlyDivider(this._constraints, this._dateTime, this._height,
      {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    String formattedDate = DateFormat("h a").format(_dateTime);
    children.add(Container(
      width: 30,
      margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Text(formattedDate,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 9,
              color: Theme.of(context).dividerColor,
              fontWeight: FontWeight.w600)),
    ));
    children.add(Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      height: 1,
      width: _constraints.maxWidth - 60,
      color: Theme.of(context).dividerColor,
    ));
    return Container(
      height: _height,
      alignment: Alignment.topLeft,
      child: Row(children: children),
    );
  }
}
