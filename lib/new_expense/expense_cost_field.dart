import 'package:flutter/material.dart';

class ExpenseCostField extends StatelessWidget {
  final TextEditingController amountController;

  const ExpenseCostField({required this.amountController, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: amountController,
        maxLength: 50,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        // Declare which keyboard you want - some are specialized for emails, etc.
        decoration: const InputDecoration(
          prefixText: '\$ ',
          label: Text('Amount'),
        ),
      ),
    );
  }
}
