import 'package:flutter/material.dart';

class TodayIndicator extends StatelessWidget {
  final BoxConstraints _constraints;

  const TodayIndicator(this._constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(Container(
      width: 15,
      margin: const EdgeInsets.symmetric(horizontal: 1),
    ));
    children.add(Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor,
          borderRadius: BorderRadius.circular(8)),
    ));
    children.add(Container(
      width: _constraints.maxWidth - 35,
      height: 1.5,
      color: Theme.of(context).indicatorColor,
    ));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
