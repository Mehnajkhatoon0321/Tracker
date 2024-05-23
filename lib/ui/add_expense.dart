import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tracker/bloc/expense_bloc.dart';
import 'package:tracker/bloc/expense_event.dart';
import 'package:tracker/bloc/expense_state.dart';
import 'package:tracker/model/model.dart';
import 'package:tracker/utils/animations.dart';
import 'package:tracker/utils/common_methods.dart';
import 'package:tracker/utils/font_style.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late double _amount;
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
  late String _description;
  bool _isLoading = false;
   DateTime dateValue= DateTime.now();
   TimeOfDay timeValue= TimeOfDay.now();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  const Text('Add Expense',style: FTextStyle.appTitleStyle,),
      ),
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is ExpenseLoaded) {
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context, [true]);
          } else if (state is ExpenseError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return  Column(
            children: [
              const Divider(thickness: 1.2, color: Color(0XFFF6F6F6)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const

                        Text("Amount", style: FTextStyle.heading),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      TextFormField(
                        cursorColor: Colors.pinkAccent,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          hintStyle: FTextStyle.hintStyle,
                          errorStyle: FTextStyle.error,
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              )



                          ),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                              )),

                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                              )),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                        ),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [LengthLimitingTextInputFormatter(254)],

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Please enter an amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = double.parse(value!);
                        },
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Description", style: FTextStyle.heading),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: FTextStyle.hintStyle,
                          errorStyle: FTextStyle.error,
                          border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )



          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                              )),

                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                              )),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                          ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text("Date", style: FTextStyle.heading),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration:  InputDecoration(
                                hintText: 'Date',
                                hintStyle: FTextStyle.hintStyle,
                                errorStyle: FTextStyle.error,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    )



                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    )),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    )),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    final selectedDate = await CommonMethods.selectDate(context);
                                    final selectedTime = await CommonMethods.selectTime(context);

                                    setState(() {
                                      dateValue = selectedDate;
                                      timeValue = selectedTime;
                                    });
                                  },
                                ),
                              ),
                              readOnly: true,
                              controller: TextEditingController(
                                text: CommonMethods.formatDateTime(dateValue, timeValue),
                              ),
                            ),
                          ),
                        ],
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final expense = Expense(
                                amount: _amount,
                                date: CommonMethods.parseDateTime(CommonMethods.formatDateTime(dateValue, timeValue)),
                                description: _description,
                              );
                              final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
                              expenseBloc.add(AddExpense(expense)); // Dispatch AddExpense event
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.pinkAccent,
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : const Text('Add Expense', style: FTextStyle.whiteTitle),
                        ),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                    ],
                  ),
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}


