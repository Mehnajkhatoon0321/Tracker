import 'package:flutter/material.dart';
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

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  EditExpenseScreen({required this.expense});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late double _amount;
  late DateTime _date;
  late String _description;
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
  @override
  void initState() {
    super.initState();
    _amount = widget.expense.amount;
    _date = widget.expense.date;
    _description = widget.expense.description;
  }
  DateTime dateValue= DateTime.now();
  TimeOfDay timeValue= TimeOfDay.now();
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense',style: FTextStyle.appTitleStyle,),
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
            Navigator.pop(context,[true]);
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
          return Column(
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

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Amount", style: FTextStyle.heading),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),


                      TextFormField(
                        decoration: const InputDecoration(
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
                        initialValue: _amount.toString(),

                        keyboardType: TextInputType.number,
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
                        initialValue: _description,
                        decoration: const InputDecoration(
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
                        onSaved: (value) {
                          _description = value!;
                        },
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Date", style: FTextStyle.heading),
                      ).animateOnPageLoad(animationsMap[
                      'imageOnPageLoadAnimation2']!),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration:  InputDecoration(
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
                                hintText: 'Date',
                                hintStyle: FTextStyle.hintStyle,
                                errorStyle: FTextStyle.error,
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

                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final updatedExpense = Expense(
                              id: widget.expense.id,
                              amount: _amount,
                              date:  CommonMethods.parseDateTime(CommonMethods.formatDateTime(dateValue, timeValue)),
                              description: _description,
                            );
                            context.read<ExpenseBloc>().add(UpdateExpense(
                                updatedExpense));

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.pinkAccent,
                          elevation: 0,
                        ),
                        child:_isLoading ? const Center(
                          child: CircularProgressIndicator(),
                        ): const Text('Update Expense', style: FTextStyle.whiteTitle),
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

