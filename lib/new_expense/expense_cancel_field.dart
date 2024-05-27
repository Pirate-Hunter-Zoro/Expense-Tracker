import 'package:flutter/material.dart';

class ExpenseCancelField extends StatelessWidget {
  const ExpenseCancelField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Close out of the expense creation dialog
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );
  }
}
