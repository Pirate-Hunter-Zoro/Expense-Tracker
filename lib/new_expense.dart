import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';

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

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _amountController.text); // parses a double if it can, else return null
    final amountIsInvalid =
        (enteredAmount == null || enteredAmount < 0) ? true : false;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        (_selectedDate == null)) {
      // Show the error dialog and then STOP
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          16, 48, 16, 16), // Need more room from the top
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            // Declare which keyboard you want - some are specialized for emails, etc.
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              // This row will have TWO Expanded widgets - which means each will take up 50% of the space.
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  // Declare which keyboard you want - some are specialized for emails, etc.
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: Theme.of(context).dropdownMenuTheme.textStyle,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  // Then set the new category, and update the UI
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                }, // Acts depending on the item selected
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Close out of the expense creation dialog
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
