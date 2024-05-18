import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Creates a scollable list of widgets - significant performance boost over a row or column
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, idx) => Text(expenses[idx].title),
    );
  }
}
