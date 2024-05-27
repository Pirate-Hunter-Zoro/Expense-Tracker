import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';

class ExpenseCategoryField extends StatelessWidget {
  final Category selectedCategory;
  final void Function(Category?) onCategorySelected;

  const ExpenseCategoryField(
      {required this.selectedCategory,
      required this.onCategorySelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
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
      onChanged: (value) =>
          onCategorySelected, // Acts depending on the item selected
    );
  }
}
