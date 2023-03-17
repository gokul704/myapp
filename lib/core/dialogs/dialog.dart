import 'package:flutter/material.dart';

class HCNAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String actionText;
  final VoidCallback? onActionPressed;

  HCNAlertDialog(this.title, this.message, {this.actionText = 'OK', this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4), child: Text(title)),
            Container(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 4), child: Text(message)),
            Container(
                child: ElevatedButton(
              child: Text(this.actionText),
              onPressed: () => this._defaultAction(context),
            )),
          ],
        ),
      ),
    );
  }

  void _defaultAction(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    if (this.onActionPressed != null) this.onActionPressed!();
  }
}
