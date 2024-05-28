import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class FancyButton extends StatefulWidget {
  const FancyButton({
    super.key,
    required this.buttonSize,
    required this.buttonText,
    required this.onPressed,
  });

  final Size buttonSize;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonSize.width,
      height: widget.buttonSize.height,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: TextButton(
          style: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              ThemeColors.gruvDark,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(
                  width: 2,
                  color: ThemeColors.gruvDark,
                ),
              ),
            ),
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.buttonText,
            style: const TextStyle(
              color: ThemeColors.gruvDark,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
