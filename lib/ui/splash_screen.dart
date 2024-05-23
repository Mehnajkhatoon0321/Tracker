import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/bloc/expense_bloc.dart';
import 'package:tracker/repository/expense_repository.dart';
import 'package:tracker/ui/home.dart';
class SplashScreen extends StatefulWidget {
  final ExpenseRepository repository;
  const SplashScreen({ required this.repository,super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () => navigateUser(context),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
              height: 90,
              child: Image.asset(
                'assets/Images/splash.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),

    );
  }

  navigateUser(BuildContext context) {

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => ExpenseBloc(widget.repository),
          child: HomeScreen(),
        );
      }),
          (route) => false,
    );
  }
}
