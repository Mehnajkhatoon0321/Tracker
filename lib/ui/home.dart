import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tracker/bloc/expense_bloc.dart';
import 'package:tracker/bloc/expense_event.dart';
import 'package:tracker/bloc/expense_state.dart';
import 'package:tracker/repository/expense_repository.dart';
import 'package:tracker/ui/add_expense.dart';
import 'package:tracker/ui/edit_expenses.dart';
import 'package:tracker/utils/animations.dart';
import 'package:tracker/utils/font_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpenses());
    super.initState();
  }

  bool showOptions = false;
  bool isActiveWeek = true;
  bool isActiveMonths = false;
  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 20.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(40.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };
  void _showFilterDialog(ExpenseBloc expenseBloc) async {
    DateTime? selectedDate;
    final TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Date',style: FTextStyle.heading,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  border:
                  const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )



                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                      )),

                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                  hintText: 'Select Date',
                  hintStyle: FTextStyle.hintStyle,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        selectedDate = picked;
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(picked);
                      }
                    },
                  ),
                ),
              ).animateOnPageLoad(animationsMap[
              'imageOnPageLoadAnimation2']!),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',style: FTextStyle.pinkTitle,),
            ).animateOnPageLoad(animationsMap[
        'imageOnPageLoadAnimation2']!),
            TextButton(
              onPressed: () {
                if (selectedDate != null) {
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate!);
                  expenseBloc.add(FilterExpensesByDate(formattedDate));
                  Navigator.of(context).pop();
                } else {
                  // If no date is selected, fetch all expenses
                  expenseBloc.add(LoadExpenses());
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Apply',style: FTextStyle.pinkTitle),
            ).animateOnPageLoad(animationsMap[
        'imageOnPageLoadAnimation2']!),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,style: FTextStyle.heading,).animateOnPageLoad(animationsMap[
          'imageOnPageLoadAnimation2']!),
          content: Text(content,style: FTextStyle.subtitle).animateOnPageLoad(animationsMap[
          'imageOnPageLoadAnimation2']!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',style: FTextStyle.pinkTitle,),
            ).animateOnPageLoad(animationsMap[
            'imageOnPageLoadAnimation2']!),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text('OK',style: FTextStyle.pinkTitle,).animateOnPageLoad(animationsMap[
              'imageOnPageLoadAnimation2']!),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Expense Tracker',style: FTextStyle.appTitleStyle,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () =>
                  _showFilterDialog(BlocProvider.of<ExpenseBloc>(context)),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 0.90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 1.2, color: Color(0XFFF6F6F6)),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showOptions = !showOptions; // Toggle visibility
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,

                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10),
                          ),
                        ),
                        child: const Text(
                          'Descriptions By Filter',
                          textAlign: TextAlign.center,
                          style: FTextStyle.whiteTitle,
                        ).animateOnPageLoad(animationsMap[
                        'imageOnPageLoadAnimation2']!),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showOptions,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<ExpenseBloc>()
                                    .add(SortExpensesByWeek());
                                setState(() {
                                  isActiveWeek=true;
                                  isActiveMonths=false;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:isActiveWeek? Colors.pinkAccent:Colors.grey,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners for the button
                                ),
                              ),
                              child: const Text(
                                "Filter From Current Week",
                                textAlign: TextAlign.center,
                                style: FTextStyle.whiteTitle,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: width * 0.4,
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<ExpenseBloc>()
                                    .add(SortExpensesByMonth());
                                setState(() {
                                  isActiveWeek=false;
                                  isActiveMonths=true;
                                });


                              },
                              style: TextButton.styleFrom(
                                 backgroundColor:isActiveMonths? Colors.pinkAccent:Colors.grey,


                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners for the button
                                ),
                              ),
                              child: const Text(
                                'Filter From Current Month',
                                textAlign: TextAlign.center,
                                style: FTextStyle.whiteTitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap[
                  'imageOnPageLoadAnimation2']!),
                  const SizedBox(height: 10,),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.expenses.length,
                          itemBuilder: (context, index) {
                            final expenses = state.expenses;
                            expenses.sort((a, b) => a.date
                                .compareTo(b.date)); // Sort expenses by date

                            final expense = expenses[index];
                            String formattedDate =
                                DateFormat('yyyy-MM-dd hh:mm aa')
                                    .format(expense.date);

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Row(
                                            children: [
                                              const Text('Amount : ',style:FTextStyle.heading,),
                                              Text('${expense.amount}',style:FTextStyle.subtitle,),
                                            ],
                                          ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation2']!),


                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ExpenseBloc(
                                                                      ExpenseRepository()),
                                                              child:
                                                              EditExpenseScreen(
                                                                  expense:
                                                                  expense),
                                                            ),
                                                      ),
                                                    ).then((value) {
                                                      if (value != null) {
                                                        context
                                                            .read<
                                                            ExpenseBloc>()
                                                            .add(
                                                            LoadExpenses());
                                                      }
                                                    });

                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    _showConfirmationDialog(
                                                      title: 'Delete Expense',
                                                      content:
                                                      'Are you sure you want to delete this expense?',
                                                      onConfirm: () {
                                                        context
                                                            .read<ExpenseBloc>()
                                                            .add(DeleteExpense(
                                                            expense.id!));
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ).animateOnPageLoad(animationsMap[
                                            'imageOnPageLoadAnimation2']!),




                                          ],
                                        ),



                                        const Text('Descriptions :- ',style:FTextStyle.heading).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation2']!).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation2']!),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 12),
                                          child: Text(expense.description,style:FTextStyle.subtitle,maxLines: 4,),
                                        ).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation2']!),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(formattedDate,style:FTextStyle.heading,textAlign: TextAlign.right,)),
                                        ).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation2']!),
                                      ],
                                    ),
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                              'imageOnPageLoadAnimation2']!),
                            );
                          }))
                ],
              ),
            );
          } else if (state is ExpenseEmpty) {
            return Center(child: Text(state.message));
          } else if (state is ExpenseError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExpenseBloc(ExpenseRepository()),
                child: const AddExpenseScreen(),
              ),
            ),
          ).then((value) {
            if (value != null) {
              context.read<ExpenseBloc>().add(LoadExpenses());
            }
          });
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
