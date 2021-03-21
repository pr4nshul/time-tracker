import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  Widget buildMaterial(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return buildMaterial(context);
  }
}



