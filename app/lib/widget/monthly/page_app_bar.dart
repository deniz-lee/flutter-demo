import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(50.0);

  final DateTime? _dateTime;

  const PageAppBar(this._dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String title = "${DateFormat.MMM().format(now)} ${now.year.toString()}";

    return AppBar(
      title: null,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leadingWidth: 160,
      leading: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Text(
            title,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          )),
    );
  }
}
