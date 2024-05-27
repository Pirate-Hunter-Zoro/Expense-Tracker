import 'package:flutter/material.dart';

class ExpenseTitleField extends StatelessWidget {
  final TextEditingController titleController;

  const ExpenseTitleField({required this.titleController, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: titleController,
        maxLength: 50,
        keyboardType: TextInputType.text,
        // Declare which keyboard you want - some are specialized for emails, etc.
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      ),
    );
  }
}
