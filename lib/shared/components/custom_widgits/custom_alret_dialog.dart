import 'package:flutter/material.dart';
import 'package:wave_app/shared/styles/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String question;
  const CustomAlertDialog({super.key, required this.title, required this.question});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      title: Text(title),
      content: Text(question),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: lightColor),
          onPressed: () {
            Navigator.of(context).pop(false); // No
          },
          child: const Text('لا'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Yes
          },
          child: const Text('نعم'),
        ),
      ],
    );
  }
}
