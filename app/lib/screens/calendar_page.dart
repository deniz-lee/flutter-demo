import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  late CalendarProvider? _calendarProvider;

  @override
  Widget build(BuildContext context) {
    _calendarProvider = Provider.of<CalendarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App Bar'),
      ),
      body: Center(
        child: Container(child: Consumer<CalendarProvider>(
          builder: (context, provider, child) {
            return Text(
              "Count: ${_calendarProvider?.count}",
              style: const TextStyle(fontSize: 50),
            );
          },
        )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              _calendarProvider?.add();
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.delete),
            onPressed: () {
              _calendarProvider?.minus();
            },
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
