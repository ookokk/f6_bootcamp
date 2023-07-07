import 'package:flutter/material.dart';

import '../text_style.dart';

class AuthScreenButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const AuthScreenButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: kMediumLargeWText,
          ),
        ),
      ),
    );
  }
}
