import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.textController,
    required this.textFocus,
    required this.textLabel,
    required this.textSize,
    required this.textHidden,
  });

  final TextEditingController textController;
  final FocusNode textFocus;
  final String textLabel;
  final Size textSize;
  final bool textHidden;

  @override
  State<InputField> createState() => _InputFieldState();

  void focus() {
    textFocus.requestFocus();
  }
}

class _InputFieldState extends State<InputField> {
  late bool textHidden;
  @override
  void initState() {
    super.initState();
    textHidden = widget.textHidden;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textSize.width,
      height: widget.textSize.height,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: TextField(
          obscureText: textHidden,
          controller: widget.textController,
          cursorColor: ThemeColors.gruvDark,
          style: const TextStyle(
            color: ThemeColors.gruvDark,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            label: Text(
              widget.textLabel,
              style: const TextStyle(
                color: ThemeColors.gruvDark,
                fontSize: 14,
              ),
            ),
            labelStyle: const TextStyle(
              color: ThemeColors.gruvDark,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: ThemeColors.gruvDark,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: ThemeColors.gruvDark,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: ThemeColors.gruvDark,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hoverColor: ThemeColors.gruvDark,
            focusColor: ThemeColors.gruvDark,
            fillColor: ThemeColors.gruvDark,
            suffixIcon: widget.textHidden
                ? IconButton(
                    icon: Icon(
                      textHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        textHidden = !textHidden;
                      });
                    })
                : null,
          ),
        ),
      ),
    );
  }
}
