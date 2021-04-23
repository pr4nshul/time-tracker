import 'package:flutter/material.dart';
import 'package:time_tracker1/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String actionText;
  final String cancelText;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    @required this.actionText,
    this.cancelText,
  })  : assert(title != null),
        assert(content != null),
        assert(actionText != null);

  Future<bool> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget buildMaterial(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> actions = [];
    if (cancelText != null) {
      actions.add(
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
      );
    }
    actions.add(
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(actionText),
      ),
    );
    return actions;
  }
}
