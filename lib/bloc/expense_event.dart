import 'package:tracker/model/model.dart';
import 'package:equatable/equatable.dart';
abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  const AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;

  const UpdateExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final int id;

  const DeleteExpense(this.id);

  @override
  List<Object?> get props => [id];
}
class FilterExpensesByDate extends ExpenseEvent {
  final String date;
  FilterExpensesByDate(this.date);

}
class SortExpensesByWeek extends ExpenseEvent {}

class SortExpensesByMonth extends ExpenseEvent {}