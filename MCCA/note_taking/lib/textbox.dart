import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/theme.dart';

class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          maxLines: null,
          decoration: null,
        ),
      ),
    );
  }
}
