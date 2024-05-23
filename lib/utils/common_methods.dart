import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonMethods {
  static  final DateTime _date = DateTime.now();
  static final TimeOfDay _time = TimeOfDay.now();

  static DateTime parseDateTime(String dateTimeString) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.parse(dateTimeString);
  }

  static String formatDateTime(DateTime date, TimeOfDay time) {
    final DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.format(dateTime);
  }

  static Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _date) {
      return pickedDate;
    }
    // Add a default return statement
    return _date;
  }

  static Future<TimeOfDay> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (pickedTime != null && pickedTime != _time) {
      return pickedTime;
    }
    // Add a default return statement
    return _time;
  }

}