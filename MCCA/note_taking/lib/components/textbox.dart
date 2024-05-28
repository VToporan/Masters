import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class TextBox extends StatefulWidget {
  const TextBox({
    super.key,
    required this.textController,
    required this.textFocus,
  });

  final TextEditingController textController;
  final FocusNode textFocus;

  @override
  State<TextBox> createState() => _TextBoxState();

  String save() {
    return textController.text;
  }

  void setText(String text) {
    textController.text = text;
  }

  void clear() {
    setText("");
  }

  void focus() {
    textFocus.requestFocus();
  }
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          maxLines: null,
          decoration: null,
          cursorColor: ThemeColors.gruvDark,
          controller: widget.textController,
          focusNode: widget.textFocus,
        ),
      ),
    );
  }
}
