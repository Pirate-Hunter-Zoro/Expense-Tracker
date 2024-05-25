import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(BuildContext context) {
    // Creates a scollable list of widgets - significant performance boost over a row or column
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, idx) => Dismissible(
        // Swipe left to erase widget - but we ALSO need to remove the underlying data
        key: ValueKey(expenses[idx]),
        onDismissed: (direction) => onRemoveExpense(expenses[idx]),
        child: ExpenseItem(
          expense: expenses[idx],
        ),
      ),
    );
  }
}
