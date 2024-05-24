import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
      padding: const EdgeInsets.all(16),
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
                onPressed: () {},
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
