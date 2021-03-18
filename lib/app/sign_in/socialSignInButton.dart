import 'package:flutter/material.dart';
import 'package:time_tracker1/common_widgets/customRaisedButton.dart';


class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String text,
    VoidCallback onPressed,
    Color color,
    double borderRadius,
    Color textColor,
    @required String assetName,
  })  : assert(text != null),
        assert(assetName != null),
        super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetName),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: textColor,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetName),
                ),
              ],
            ),
            onPressed: onPressed,
            color: color,
            borderRadius: borderRadius = 4.0,
            padding: 16.0);
}
