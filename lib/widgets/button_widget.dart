import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final Color color;
  const ButtonWidget(
      {required this.buttonText, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
          minWidth: 200.0,
          height: 42.0,
        ),
      ),
    );
  }
}
