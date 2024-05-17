import 'package:uuid/uuid.dart';

const uuid = Uuid();

// What categories will we allow for our Expenses?
enum Category { food, travel, leisure, work }

class Expense {
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final String id;

  Expense({required this.title, required this.amount, required this.date, required this.category})
      : id = uuid.v4();
}
