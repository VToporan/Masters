import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                        DateTime date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.utc(2010),
                              lastDate: DateTime.utc(2025),
                              builder: (BuildContext context, Widget? child) {
                                return DatePickerTheme(
                                  data: const DatePickerThemeData(
                                    backgroundColor: ThemeColors.gruvLight,
                                    dividerColor: ThemeColors.gruvDark,
                                    headerForegroundColor: ThemeColors.gruvDark,
                                    shadowColor: ThemeColors.gruvLight,
                                    surfaceTintColor: Colors.transparent,
                                    yearStyle: TextStyle(
                                        color: ThemeColors.gruvDark,
                                        fontSize: 14),
                                    todayBorder:
                                        BorderSide(color: ThemeColors.gruvDark),
                                    dayStyle:
                                        TextStyle(color: ThemeColors.gruvDark),
                                    weekdayStyle:
                                        TextStyle(color: ThemeColors.gruvDark),
                                    headerHelpStyle: TextStyle(
                                        color: ThemeColors.gruvDark,
                                        fontSize: 16),
                                    headerHeadlineStyle: TextStyle(
                                        color: ThemeColors.gruvDark,
                                        fontSize: 16),
                                    cancelButtonStyle: ButtonStyle(
                                        foregroundColor: WidgetStatePropertyAll(
                                            ThemeColors.gruvDark)),
                                    confirmButtonStyle: ButtonStyle(
                                        foregroundColor: WidgetStatePropertyAll(
                                            ThemeColors.gruvDark)),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 3,
                                            color: ThemeColors.gruvDark),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                  child: child ?? const SizedBox(),
                                );
                              },
                            ) ??
                            DateTime.now();
                        debugPrint(date.toString());
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
