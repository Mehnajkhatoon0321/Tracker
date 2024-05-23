/*
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> showDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay notificationTime,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_notification',
      'Daily Notification',
      importance: Importance.high,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(notificationTime),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
*/
/*

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tracker/repository/expense_repository.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final ExpenseRepository _expenseRepository = ExpenseRepository();

  static Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> startBackgroundService() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Schedule background task for both platforms
    if (Platform.isAndroid) {
      // For Android
      _startAndroidBackgroundService();
    } else if (Platform.isIOS) {
      // For iOS
      _startIOSBackgroundService();
    }
  }

  static void _startAndroidBackgroundService() {
    // Using WorkManager or android_alarm_manager for Android background tasks
    // You need to implement this part based on your preference
    // Here's a simplified example using Timer.periodic
    Timer.periodic(const Duration(minutes: 15), (timer) async {
      await _checkAndShowNotificationFromDatabase();
    });
  }

  static void _startIOSBackgroundService() {
    // Using background_fetch for iOS background tasks
    // You need to implement this part based on background_fetch package
    // Refer to the background_fetch documentation for implementation details
  }

  static Future<void> _checkAndShowNotificationFromDatabase() async {
    final now = DateTime.now();
    final expenses = await _expenseRepository.getExpensesByDate('${now.year}-${now.month}-${now.day}');

    for (var expense in expenses) {
      await showNotification(
        id: expense.id!,
        title: expense.description,
        body: 'Expense: \$${expense.amount}',
      );
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_notification',
      'Daily Notification',
      importance: Importance.high,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:tracker/repository/expense_repository.dart';



class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final ExpenseRepository _expenseRepository = ExpenseRepository();

  static Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> startBackgroundService() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Start a background task to check and show notifications
    _startDailyNotificationTask();
  }

  static void _startDailyNotificationTask() {
    Timer.periodic(Duration(minutes: 1), (timer) async {
      await _checkAndShowNotificationFromDatabase();
    });
  }

  static Future<void> _checkAndShowNotificationFromDatabase() async {
    final now = DateTime.now();
    final expenses = await _expenseRepository.getExpenses();
    String nowFormatDate = DateFormat('yyyy-MM-dd HH:mm').format(now);

    for (var expense in expenses) {
      String storedFormatDate = DateFormat('yyyy-MM-dd HH:mm').format(expense.date);
      if (nowFormatDate == storedFormatDate) {
        await showNotification(
          id: expense.id!,
          title: expense.description,
          body: 'Expense: ${expense.amount}',
        );
      }
    }
  }

  static bool _isExpenseTimeMatch(DateTime now, DateTime expenseDate) {
    return now.hour == expenseDate.hour && now.minute == expenseDate.minute;
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_notification',
      'Daily Notification',
      importance: Importance.high,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
