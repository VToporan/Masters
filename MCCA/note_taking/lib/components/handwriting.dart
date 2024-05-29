import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_taking/theme.dart';
import 'package:finger_painter/finger_painter.dart';

class HandWriting extends StatefulWidget {
  HandWriting({super.key});

  final PainterController painterController = PainterController();

  String save() {
    return base64.encode(painterController.getImageBytes()!);
  }

  void focus() {
    painterController.setMaxStrokeWidth(3);
    painterController.setMinStrokeWidth(3);
    painterController.setStrokeColor(ThemeColors.gruvDark);
    painterController.setBlendMode(ui.BlendMode.srcOver);
  }

  void eraser() {
    painterController.setMaxStrokeWidth(15);
    painterController.setMinStrokeWidth(15);
    painterController.setStrokeColor(ThemeColors.gruvLight);
    painterController.setBlendMode(ui.BlendMode.dstOut);
  }

  void clear() {
    painterController.clearContent(
        clearColor: const ui.Color.fromARGB(1, 251, 241, 198));
  }

  void setImage(Uint8List image) {
    painterController.setBackgroundImage(image);
  }

  @override
  State<HandWriting> createState() => _HandWritingState();
}

class _HandWritingState extends State<HandWriting> {
  @override
  void initState() {
    super.initState();
    widget.focus();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Painter(
        controller: widget.painterController,
        backgroundColor: const ui.Color.fromARGB(1, 251, 241, 198),
        onDrawingEnded: (bytes) async {
          setState(() {});
        },
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }
}
