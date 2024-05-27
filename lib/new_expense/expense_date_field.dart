import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDateField extends StatelessWidget {
  final DateFormat formatter;
  final DateTime? selectedDate;
  final void Function() presentDate;

  const ExpenseDateField(
      {required this.formatter,
      required this.selectedDate,
      required this.presentDate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          const Spacer(),
          Text(
            selectedDate == null
                ? 'No date selected'
                : formatter.format(selectedDate!),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            onPressed: presentDate,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
