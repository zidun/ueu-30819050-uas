import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final onPressed;
  final String text;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double paddinV;
  final double paddinH;
  final double radius;
  final TextStyle? textStyle;
  final bool isCustomStyle;
  final bool disabled;

  Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.bgColor = Colors.black,
    this.borderColor = Colors.black,
    this.paddinV = 16,
    this.paddinH = 24,
    this.radius = 8,
    this.textStyle,
    this.isCustomStyle = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!disabled) {
          onPressed();
        }
      },
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(
            disabled ? Color.fromRGBO(0, 0, 0, 0.5) : bgColor),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: paddinV, horizontal: paddinH)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color: disabled ? Color.fromRGBO(0, 0, 0, 0.5) : borderColor!,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      child: Text(
        text,
        style: isCustomStyle
            ? textStyle
            : TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
