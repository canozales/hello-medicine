import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  ButtonPrimary({this.text, this.onTap, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: color == null ? redColor : color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
