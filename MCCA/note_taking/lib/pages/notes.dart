import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:note_taking/components/fancyButton.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';
import 'package:note_taking/theme.dart';

class Notes extends StatefulWidget {
  Notes({super.key});

  final TextBox inputBox = TextBox(
    textController: TextEditingController(),
    textFocus: FocusNode(),
  );
  final HandWriting writingBox = HandWriting();

  @override
  State<Notes> createState() => _NotesState();

  void setValues(String image, String text) {
    writingBox.clear();
    writingBox.setImage(base64Decode(image));
    inputBox.clear();
    inputBox.setText(text);
  }
}

String formatTimeOfDay(TimeOfDay pickedTime) {
  return '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
}

class _NotesState extends State<Notes> {
  late Widget backWidget = widget.inputBox;
  late Widget frontWidget = widget.writingBox;

  late final pageMenu = PageMenu(menuFunctions: {
    () {
      Future.delayed(Duration.zero, () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: ThemeColors.gruvLight,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 3, color: ThemeColors.gruvDark),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  title: const Text("Save note?"),
                  content: const SizedBox(
                    width: 280,
                    height: 0,
                  ),
                  actions: <Widget>[
                    FancyButton(
                      buttonSize: const Size(140, 40),
                      buttonText: "Save for later",
                      onPressed: () {
                        String userID = FirebaseAuth.instance.currentUser!.uid;
                        DatabaseReference ref =
                            FirebaseDatabase.instance.ref('users/$userID');
                        ref.child("latest").set({
                          "text": widget.inputBox.save(),
                          "image": widget.writingBox.save(),
                        });
                        Navigator.pop(context);
                      },
                    ),
                    FancyButton(
                      buttonSize: const Size(140, 40),
                      buttonText: "Set reminder",
                      onPressed: () async {
                        Navigator.pop(context);
                        Future.delayed(
                          Duration.zero,
                          () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                late DateTime selectedDate = DateTime.now();
                                late TimeOfDay selectedTime = TimeOfDay.now();

                                return StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    backgroundColor: ThemeColors.gruvLight,
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: ThemeColors.gruvDark),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    title: const Text("Select date and time"),
                                    content: const SizedBox(
                                      width: 280,
                                      height: 0,
                                    ),
                                    actions: <Widget>[
                                      FancyButton(
                                        buttonSize: const Size(90, 40),
                                        buttonText: DateFormat("dd-MM-yy")
                                            .format(selectedDate),
                                        onPressed: () async {
                                          DateTime date = await showDatePicker(
                                                context: context,
                                                firstDate: DateTime.utc(2024),
                                                lastDate: DateTime.utc(2035),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return DatePickerTheme(
                                                    data:
                                                        const DatePickerThemeData(
                                                      backgroundColor:
                                                          ThemeColors.gruvLight,
                                                      dividerColor:
                                                          ThemeColors.gruvDark,
                                                      headerForegroundColor:
                                                          ThemeColors.gruvDark,
                                                      shadowColor:
                                                          ThemeColors.gruvLight,
                                                      surfaceTintColor:
                                                          Colors.transparent,
                                                      yearStyle: TextStyle(
                                                          color: ThemeColors
                                                              .gruvDark,
                                                          fontSize: 14),
                                                      todayBorder: BorderSide(
                                                          color: ThemeColors
                                                              .gruvDark),
                                                      dayStyle: TextStyle(
                                                          color: ThemeColors
                                                              .gruvDark),
                                                      weekdayStyle: TextStyle(
                                                          color: ThemeColors
                                                              .gruvDark),
                                                      headerHelpStyle:
                                                          TextStyle(
                                                              color: ThemeColors
                                                                  .gruvDark,
                                                              fontSize: 16),
                                                      headerHeadlineStyle:
                                                          TextStyle(
                                                              color: ThemeColors
                                                                  .gruvDark,
                                                              fontSize: 16),
                                                      cancelButtonStyle: ButtonStyle(
                                                          foregroundColor:
                                                              WidgetStatePropertyAll(
                                                                  ThemeColors
                                                                      .gruvDark)),
                                                      confirmButtonStyle: ButtonStyle(
                                                          foregroundColor:
                                                              WidgetStatePropertyAll(
                                                                  ThemeColors
                                                                      .gruvDark)),
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: ThemeColors
                                                                  .gruvDark),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                    ),
                                                    child: child ??
                                                        const SizedBox(),
                                                  );
                                                },
                                              ) ??
                                              DateTime.now();
                                          debugPrint(date.toString());
                                          setState(() {
                                            selectedDate = date;
                                          });
                                        },
                                      ),
                                      FancyButton(
                                        buttonSize: const Size(100, 40),
                                        buttonText:
                                            formatTimeOfDay(selectedTime),
                                        onPressed: () async {
                                          TimeOfDay time = await showTimePicker(
                                                  context: context,
                                                  initialTime: selectedTime,
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return TimePickerTheme(
                                                        data:
                                                            const TimePickerThemeData(
                                                          backgroundColor:
                                                              ThemeColors
                                                                  .gruvLight,
                                                          dialHandColor:
                                                              ThemeColors
                                                                  .gruvLight,
                                                          dialTextColor:
                                                              ThemeColors
                                                                  .gruvDark,
                                                          dayPeriodColor:
                                                              ThemeColors
                                                                  .gruvPink,
                                                          hourMinuteColor:
                                                              ThemeColors
                                                                  .gruvLight,
                                                          dayPeriodTextColor:
                                                              ThemeColors
                                                                  .gruvDark,
                                                          dialBackgroundColor:
                                                              ThemeColors
                                                                  .gruvPink,
                                                          hourMinuteTextColor:
                                                              ThemeColors
                                                                  .gruvDark,
                                                          dayPeriodBorderSide:
                                                              BorderSide(
                                                            width: 2,
                                                            color: ThemeColors
                                                                .gruvDark,
                                                          ),
                                                          cancelButtonStyle:
                                                              ButtonStyle(
                                                            foregroundColor:
                                                                WidgetStatePropertyAll(
                                                              ThemeColors
                                                                  .gruvDark,
                                                            ),
                                                            shape:
                                                                WidgetStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                side:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: ThemeColors
                                                                      .gruvDark,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          confirmButtonStyle:
                                                              ButtonStyle(
                                                            foregroundColor:
                                                                WidgetStatePropertyAll(
                                                              ThemeColors
                                                                  .gruvDark,
                                                            ),
                                                            shape:
                                                                WidgetStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                side:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: ThemeColors
                                                                      .gruvDark,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            side: BorderSide(
                                                              width: 2,
                                                              color: ThemeColors
                                                                  .gruvDark,
                                                            ),
                                                          ),
                                                        ),
                                                        child: child ??
                                                            const SizedBox());
                                                  }) ??
                                              TimeOfDay.now();
                                          DateTime.now();
                                          debugPrint(time.toString());
                                          setState(() {
                                            selectedTime = time;
                                          });
                                        },
                                      ),
                                      FancyButton(
                                        buttonSize: const Size(90, 40),
                                        buttonText: "Confirm",
                                        onPressed: () {
                                          String dateFromated =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(selectedDate);
                                          String timeFromated =
                                              formatTimeOfDay(selectedTime);
                                          debugPrint(
                                              "$dateFromated/$timeFromated");

                                          String userID = FirebaseAuth
                                              .instance.currentUser!.uid;
                                          DatabaseReference ref =
                                              FirebaseDatabase.instance.ref(
                                                  'users/$userID/calendar');
                                          ref
                                              .child(
                                                  "$dateFromated/$timeFromated")
                                              .set({
                                            "text": widget.inputBox.save(),
                                            "image": widget.writingBox.save(),
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ); //showDialog
                          },
                        );
                      },
                    ),
                  ],
                ));
      });
    }: Icons.save,
    () {
      widget.inputBox.clear();
      widget.writingBox.clear();
    }: Icons.delete,
    () {
      widget.writingBox.eraser();
    }: Icons.remove_circle_outline,
    () {
      setState(() {
        backWidget = widget.inputBox;
        frontWidget = widget.writingBox;
        widget.writingBox.focus();
      });
    }: Icons.edit,
    () {
      setState(() {
        backWidget = widget.writingBox;
        frontWidget = widget.inputBox;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.inputBox.focus();
      });
    }: Icons.text_fields_rounded,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backWidget,
        frontWidget,
        pageMenu,
      ],
    );
  }
}
