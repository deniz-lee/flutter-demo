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
  @override
  Widget build(BuildContext context) {
    if (context.watch<CalendarProvider>().state == ProviderState.done) {
      context.read<CalendarProvider>().onLoadingDialog(context, false);
    }
    return Scaffold(
      body: const GridWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignInButton(() {
            context.read<CalendarProvider>().onLoadingDialog(context, true);
            context.read<CalendarProvider>().update();
          }),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
