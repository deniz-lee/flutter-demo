import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/common/sign_in_button.dart';
import 'package:flutter_demo/widget/monthly/grid_widget.dart';
import 'package:provider/provider.dart';

class MonthlyPage extends StatefulWidget {
  const MonthlyPage({Key? key}) : super(key: key);

  @override
  State<MonthlyPage> createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  late CalendarProvider? _calendarProvider;

  @override
  Widget build(BuildContext context) {
    _calendarProvider = Provider.of<CalendarProvider>(context);
    if (_calendarProvider?.state == ProviderState.done) {
      _calendarProvider?.onLoadingDialog(context, false);
    }
    return Scaffold(
      body: const GridWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignInButton(() {
            _calendarProvider?.onLoadingDialog(context, true);
            _calendarProvider?.update();
          }),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}