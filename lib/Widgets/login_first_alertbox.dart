import 'package:flutter/material.dart';

class LoginFirstAlertDialog extends StatefulWidget {
  const LoginFirstAlertDialog({Key? key}) : super(key: key);

  @override
  State<LoginFirstAlertDialog> createState() => _LoginFirstAlertDialogState();
}

class _LoginFirstAlertDialogState extends State<LoginFirstAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            "You need to login with credentials first",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      elevation: 4,
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
    );
  }
}

void showLoginFirstAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginFirstAlertDialog();
    },
  );
}
