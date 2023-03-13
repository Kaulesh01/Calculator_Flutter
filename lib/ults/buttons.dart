import 'package:flutter/material.dart';

class buttons extends StatelessWidget {
  late Color textcolor;
  late Color bgcolor;
  late String text;
  final Function() onPressed;

  buttons(
      {required this.textcolor,
      required this.text,
      required this.bgcolor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: bgcolor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
