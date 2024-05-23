import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/bloc/expense_event.dart';
import 'package:tracker/bloc/expense_state.dart';
import 'package:tracker/model/model.dart';
import 'package:tracker/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/notification.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository;

  ExpenseBloc(this.repository) : super(ExpenseLoading()) {
    on<LoadExpenses>(_mapLoadExpensesToState);
    on<AddExpense>(_mapAddExpenseToState);
    on<UpdateExpense>(_mapUpdateExpenseToState);
    on<FilterExpensesByDate>(_mapFilterExpensesByDateToState);
    on<DeleteExpense>(_mapDeleteExpenseToState);
    on<SortExpensesByWeek>(_mapFilterExpensesByWeekToState);
    on<SortExpensesByMonth>(_mapFilterExpensesByMonthToState);
  }

  Future<void> _mapLoadExpensesToState(LoadExpenses event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      final expenses = await repository.getExpenses();
      if (expenses.isEmpty) {
        emit(ExpenseEmpty("No expenses available"));
      } else {
        emit(ExpenseLoaded(expenses));
      }
      print("Expenses loaded successfully: $expenses");
    } catch (e) {
      emit(ExpenseError('Failed to load expenses: $e'));
      print("Error loading expenses: $e");
    }
  }

  Future<void> _mapAddExpenseToState(AddExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.addExpense(event.expense);
      add(LoadExpenses());
    } catch (_) {
      emit(ExpenseError('Failed to add expense'));
    }
  }

  Future<void> _mapUpdateExpenseToState(UpdateExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.updateExpense(event.expense);
      add(LoadExpenses());
    } catch (_) {
      emit(ExpenseError('Failed to update expense'));
    }
  }

  Future<void> _mapDeleteExpenseToState(DeleteExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.deleteExpense(event.id);
      add(LoadExpenses());
    } catch (_) {
      emit(ExpenseError('Failed to delete expense'));
    }
  }

  Future<void> _mapFilterExpensesByDateToState(FilterExpensesByDate event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      print('Filtering expenses for date: ${event.date}');
      final DateTime parsedDate = DateTime.parse(event.date);
      final String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      final filteredExpenses = await repository.getExpensesByDate(formattedDate);
      print('Filtered expenses: $filteredExpenses');
      if (filteredExpenses.isEmpty) {
        emit(ExpenseEmpty('No data available on ${event.date}'));
      } else {
        emit(ExpenseLoaded(filteredExpenses));
      }
    } catch (e) {
      emit(ExpenseError(e.toString()));
      print('Error filtering expenses by date: $e');
    }
  }

  Future<void> _mapFilterExpensesByWeekToState(SortExpensesByWeek event, Emitter<ExpenseState> emit) async {
    try {
      final expenses = await repository.getExpensesByWeek();
      if (expenses.isEmpty) {
        emit(ExpenseEmpty('No expenses available for this week'));
      } else {
        emit(ExpenseLoaded(expenses));
      }
    } catch (_) {
      emit(const ExpenseError('Failed to filter expenses by week'));
    }
  }

  Future<void> _mapFilterExpensesByMonthToState(SortExpensesByMonth event, Emitter<ExpenseState> emit) async {
    try {
      final expenses = await repository.getExpensesByMonth();
      if (expenses.isEmpty) {
        emit(ExpenseEmpty('No expenses available for this month'));
      } else {
        emit(ExpenseLoaded(expenses));
      }
    } catch (_) {
      emit(const ExpenseError('Failed to filter expenses by month'));
    }
  }
}

