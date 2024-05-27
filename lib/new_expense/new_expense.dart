import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/new_expense/expense_cancel_field.dart';
import 'package:tracker_app/new_expense/expense_category_field.dart';
import 'package:tracker_app/new_expense/expense_cost_field.dart';
import 'package:tracker_app/new_expense/expense_date_field.dart';
import 'package:tracker_app/new_expense/expense_submit_field.dart';
import 'package:tracker_app/new_expense/expense_title_field.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; // Could be null
  Category _selectedCategory = Category.leisure;

  void selectCategory(Category? value) {
    // Then set the new category, and update the UI
    if (value != null) {
      setState(() {
        _selectedCategory = value;
      });
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    // When constructing a DateTime object, the only required parameter is the year
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      // This returns a FUTURE object - which will eventually be a DateTime object
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    // The following code will ONLY be executed once pickedDate is received
    setState(() {
      // Now the widget knows to rebuild the UI
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    // Depending on the device platform, we could specify a different dialog to show
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please enter a valid title, amount, date and category.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please enter a valid title, amount, date and category.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _amountController.text); // parses a double if it can, else return null
    final amountIsInvalid =
        (enteredAmount == null || enteredAmount < 0) ? true : false;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        (_selectedDate == null)) {
      // Show the error dialog and then STOP
      _showDialog();
      return;
    }

    // We can do the following because we are in a State object - it can access the NewExpense widget's 'onAddExpense' value.
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    // And close the form
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // This method is called automatically when a widget is removed from the UI.
    // ONLY STATEFUL widgets have this method!!!
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctxt, constraints) {
      // Dimensions limited by parent widget
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, keyboardSpace + 16), // Need more room from the top
            child: Column(
              children: [
                if (width > height) // NO curly braces
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpenseTitleField(titleController: _titleController),
                      const SizedBox(
                        width: 24,
                      ),
                      ExpenseCostField(amountController: _amountController),
                    ],
                  )
                else
                  Row(
                    children: [
                      ExpenseTitleField(titleController: _titleController),
                    ],
                  ),
                if (width > height)
                  Row(
                    children: [
                      ExpenseCategoryField(
                        selectedCategory: _selectedCategory,
                        onCategorySelected: selectCategory,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      ExpenseDateField(
                        formatter: formatter,
                        selectedDate: _selectedDate,
                        presentDate: _presentDatePicker,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      // This row will have TWO Expanded widgets - which means each will take up 50% of the space.
                      ExpenseCostField(
                        amountController: _amountController,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ExpenseDateField(
                        formatter: formatter,
                        selectedDate: _selectedDate,
                        presentDate: _presentDatePicker,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width > height)
                  Row(
                    children: [
                      const Spacer(),
                      const ExpenseCancelField(),
                      ExpenseSubmitField(submitExpenseData: _submitExpenseData),
                    ],
                  )
                else
                  Row(
                    children: [
                      ExpenseCategoryField(
                        selectedCategory: _selectedCategory,
                        onCategorySelected: selectCategory,
                      ),
                      const Spacer(),
                      const ExpenseCancelField(),
                      ExpenseSubmitField(submitExpenseData: _submitExpenseData),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
