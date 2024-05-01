import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextBox inputBox;
  late HandWriting writingBox;

  late Widget backWidget = inputBox;
  late Widget frontWidget = writingBox;

  late final pageMenu = PageMenu(menuFunctions: [
    () {
      inputBox.save();
    },
    () {
      setState(() {
        backWidget = inputBox;
        frontWidget = writingBox;
      });
    },
    () {
      setState(() {
        backWidget = writingBox;
        frontWidget = inputBox;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        inputBox.focus();
      });
    }
  ]);

  @override
  void initState() {
    super.initState();
    inputBox = TextBox(
      textController: TextEditingController(),
      textFocus: FocusNode(),
    );
    writingBox = HandWriting();
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
