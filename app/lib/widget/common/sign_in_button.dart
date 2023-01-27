
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInButton extends StatelessWidget {

  final Function _onPressed;
  const SignInButton(this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButtonBuilder(
      text: '',
      mini: true,
      icon: FontAwesomeIcons.google,
      width: 40,
      height: 40,
      backgroundColor: const Color(0xFF455A64),
      onPressed: _onPressed,
    );
  }
}