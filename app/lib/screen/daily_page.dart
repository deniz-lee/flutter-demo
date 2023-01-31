import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/common/sign_in_button.dart';
import 'package:flutter_demo/widget/daily/pager_widget.dart';
import 'package:provider/provider.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<CalendarProvider>().state == ProviderState.done) {
      context.read<CalendarProvider>().onLoadingDialog(context, false);
    }
    return Scaffold(
      body: const PagerWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignInButton(() {
            context.read<CalendarProvider>().onLoadingDialog(context, true);
            context.read<CalendarProvider>().update();
          }),
        ],
      ),
    );
  }
}
