import 'package:flutter/material.dart';

class DeleteUserConfirmationDialog extends StatelessWidget {
  const DeleteUserConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title:  Text(
        'Delete User Confirmation',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      content:  Text(
        'Are you sure you want to Delete User?',
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors
                .red, // Set the background color to red for a critical alert
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
