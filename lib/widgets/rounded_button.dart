import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final double buttonWidth;
  final double buttonHight;
  final VoidCallback onPressed;
  const RoundedButton(
      {required this.title,
      required this.buttonHight,
      required this.buttonWidth,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonWidth, buttonHight),
        backgroundColor: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          height: 1.5,
        ),
      ),
    );
  }
}
