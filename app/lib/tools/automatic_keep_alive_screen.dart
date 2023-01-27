import 'package:flutter/material.dart';

class AutomaticKeepAliveScreen extends StatefulWidget {
  const AutomaticKeepAliveScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AutomaticKeepAliveScreen> createState() =>
      _AutomaticKeepAliveScreenState();
}

class _AutomaticKeepAliveScreenState extends State<AutomaticKeepAliveScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
