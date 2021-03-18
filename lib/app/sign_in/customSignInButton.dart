import 'package:flutter/material.dart';
import 'package:time_tracker1/common_widgets/customRaisedButton.dart';


class CustomSignInButton extends CustomRaisedButton {
  CustomSignInButton(
      {@ required String text,
      VoidCallback onPressed,
      Color color,
      double borderRadius,
      Color textColor,
      double padding})
      : assert(text!=null),
    super(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: textColor,
              ),
            ),
            onPressed: onPressed,
            color: color,
            borderRadius: borderRadius = 4.0,
            padding: padding = 16.0);
}
