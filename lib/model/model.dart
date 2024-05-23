import 'package:intl/intl.dart';

class Expense {
  final int? id;
  final double amount;
  final DateTime date;
  final String description;

  Expense({this.id, required this.amount, required this.date, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }
}
