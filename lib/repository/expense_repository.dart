
import 'package:tracker/database/datahelper.dart';
import 'package:tracker/model/model.dart';

class ExpenseRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addExpense(Expense expense) async {
    await _dbHelper.insertExpense(expense);
  }

  Future<List<Expense>> getExpenses() async {
    return await _dbHelper.getExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _dbHelper.updateExpense(expense);
  }

  Future<void> deleteExpense(int id) async {
    await _dbHelper.deleteExpense(id);
  }

  Future<List<Expense>> getExpensesByDate(String date) async {
    return await _dbHelper.getExpensesByDate(date);
  }

  Future<List<Expense>> getExpensesByWeek() async {
    return await _dbHelper.getExpensesByWeek();
  }

  Future<List<Expense>> getExpensesByMonth() async {
    return await _dbHelper.getExpensesByMonth();
  }
}