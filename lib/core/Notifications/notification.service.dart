import 'package:flutter/material.dart';
import 'package:myapp/core/router/router.dart';
import 'package:myapp/core/shared/dialogs/dialog.dart';

class NotificationService {
  void showSuccess(String title, String message) {
    showDialog(
        context: CustomRouter.context,
        builder: (_) => CustomAlertDialog(title, message));
  }

  void showError(String title, String message,
      {VoidCallback? onActionPressed}) {
    showDialog(
        context: CustomRouter.context,
        builder: (_) => CustomAlertDialog(title, message,
            onActionPressed: onActionPressed));
  }

  void showWarning(String title, String message) {
    showDialog(
        context: CustomRouter.context,
        builder: (_) => CustomAlertDialog(title, message));
  }

  void showInfo(String title, String message) {
    showDialog(
        context: CustomRouter.context,
        builder: (_) => CustomAlertDialog(title, message));
  }
}
