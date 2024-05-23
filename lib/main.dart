import 'package:flutter/material.dart';
import 'package:tracker/database/datahelper.dart';
import 'package:tracker/repository/expense_repository.dart';
import 'package:tracker/ui/splash_screen.dart';
import 'package:tracker/utils/notification.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await NotificationService.startBackgroundService();
  await DatabaseHelper().database; // Initialize the database


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(repository: ExpenseRepository(),)
    );
  }
}


