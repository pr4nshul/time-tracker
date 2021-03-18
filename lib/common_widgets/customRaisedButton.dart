import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.padding,
    @required this.child,
    this.color,
    this.onPressed,
    this.borderRadius,
  }) ;
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color,
      child: child,
      onPressed: onPressed,
      padding: EdgeInsets.all(padding),
    );
  }
}
