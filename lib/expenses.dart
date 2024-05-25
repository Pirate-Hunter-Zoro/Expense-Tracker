import 'package:flutter/material.dart';
import 'package:tracker_app/new_expense.dart';
import 'package:tracker_app/widgets/chart/chart.dart';
import 'package:tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:tracker_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'One Piece Suitcase',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'The Boy and the Heron',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // Since we're in a class that extends State<>, we already have a context field
    showModalBottomSheet(
      isScrollControlled:
          true, // Now the keyboard will not cover up input fields because this form now starts at the top of the screen
      context: context,
      builder: (ctxt) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // ScaffoldMessenger has an 'of' constructor
    // This CLEARS all previously seen 'expense deleted' snackbars - which is desirable if you clear out more than 1 expense in less than 3 seconds
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show the 'snackbar' for a newly deleted expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        // We have 3 seconds to undo that delete
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Flutter ExpenseTracker'),
            Spacer(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpenses,
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
