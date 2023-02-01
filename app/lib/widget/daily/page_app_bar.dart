import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(50.0);
  final DateTime? _dateTime;

  const PageAppBar(this._dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = _dateTime ?? DateTime.now();
    String title =
        "${dateTime.day} ${DateFormat.MMM().format(dateTime)} ${dateTime.year.toString()}";

    return AppBar(
      title: null,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leadingWidth: 160,
      leading: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child:
              Text(title, style: Theme.of(context).appBarTheme.titleTextStyle)),
    );
  }
}
