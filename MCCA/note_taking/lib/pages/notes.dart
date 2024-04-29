import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';
import 'package:note_taking/theme.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
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
      inputBox.focus();
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
