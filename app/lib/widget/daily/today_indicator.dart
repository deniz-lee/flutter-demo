import 'package:flutter/material.dart';

class TodayIndicator extends StatelessWidget {
  final BoxConstraints _constraints;

  const TodayIndicator(this._constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    // DateTime now = DateTime.now();
    // int offset = now.hour * 60 + now.minute;
    // String formattedDate = DateFormat("h:mm").format(now);
    // children.add(Container(
    //   width: 35,
    //   margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
    //   child: Text(formattedDate,
    //       textAlign: TextAlign.right,
    //       style: const TextStyle(
    //           fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
    // ));
    children.add(Container(
      width: 15,
      margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
    ));
    children.add(Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(8)),
    ));
    children.add(Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: _constraints.maxWidth - 35,
      height: 1.5,
      color: Colors.red,
    ));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
