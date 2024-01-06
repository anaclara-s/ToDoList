import 'package:flutter/material.dart';

class CustomAlertDialog {
  static CustomAlertDialog? _instance;

  CustomAlertDialog._();

  static CustomAlertDialog get instance {
    _instance ??= CustomAlertDialog._();
    return _instance!;
  }

  Future<Map<String, bool>?> asyncConfirmDialog({
    required BuildContext context,
    required String title,
    required String textConfirm,
    required String textCancel,
    required Widget content,
  }) {
    return showDialog<Map<String, bool>>(
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text(
                textConfirm,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop({'resp': true});
              },
            ),
            TextButton(
              child: Text(
                textCancel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop({'resp': false});
              },
            ),
          ],
        );
      },
      context: context,
    );
  }
}
