import 'package:equatable/equatable.dart';
import 'package:tracker/model/model.dart';


abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;

  const ExpenseLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
class ExpenseEmpty extends ExpenseState {
  final String message;
  ExpenseEmpty(this.message);
  @override
  List<Object?> get props => [message];
}
