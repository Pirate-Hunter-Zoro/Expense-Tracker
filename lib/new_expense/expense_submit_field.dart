import 'package:flutter/material.dart';

class ExpenseSubmitField extends StatelessWidget {
  final void Function() submitExpenseData;

  const ExpenseSubmitField({required this.submitExpenseData, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submitExpenseData,
      child: const Text('Save Expense'),
    );
  }
}
