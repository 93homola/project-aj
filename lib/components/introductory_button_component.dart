import 'package:flutter/material.dart';

class IntroductoryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const IntroductoryButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
