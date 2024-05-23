import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:tracker/model/model.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expenses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        date TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<int> updateExpense(Expense expense) async {
    Database db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<List<Expense>> getExpensesByDate(String date) async {
    final db = await database;

    // Query to filter expenses by date
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT * FROM expenses WHERE DATE(date) = ?
    ''', [date]);

    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        date: DateFormat('yyyy-MM-dd').parse(maps[i]['date']),
        description: maps[i]['description'],
      );
    });
  }

  Future<int> deleteExpense(int id) async {
    Database db = await database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Expense>> getExpensesByWeek() async {
    Database db = await database;
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'DATE(date) BETWEEN ? AND ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(startOfWeek), DateFormat('yyyy-MM-dd').format(endOfWeek)],

    );

    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
      );
    });
  }

  Future<List<Expense>> getExpensesByMonth() async {
    Database db = await database;
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month, 1);
    final DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'DATE(date) BETWEEN ? AND ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(startOfMonth), DateFormat('yyyy-MM-dd').format(endOfMonth)],
    );

    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
      );
    });
  }
}
