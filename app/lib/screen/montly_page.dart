import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/common/sign_in_button.dart';
import 'package:flutter_demo/widget/monthly/grid_widget.dart';
import 'package:flutter_demo/widget/monthly/page_app_bar.dart';
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
    return Scaffold(
      body: const GridWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignInButton(() {
            _calendarProvider?.update();
          }),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// if (_calendarProvider?.onLoaded == true) {
// Navigator.of(context).pop();
// }
// showDialog(
// // The user CANNOT close this dialog  by pressing outsite it
// barrierDismissible: false,
// context: context,
// builder: (_) {
// return Dialog(
// // The background color
// backgroundColor: Colors.white,
// child: Padding(
// padding: const EdgeInsets.symmetric(vertical: 20),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: const [
// // The loading indicator
// CircularProgressIndicator(),
// SizedBox(
// height: 15,
// ),
// // Some text
// Text('Loading...')
// ],
// ),
// ),
// );
// });
