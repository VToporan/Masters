import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finger_painter/finger_painter.dart';

import 'dart:ui' as ui;

import 'theme.dart';

class HandWriting extends StatefulWidget {
  const HandWriting({super.key});

  @override
  State<HandWriting> createState() => _HandWritingState();
}

class _HandWritingState extends State<HandWriting> {
  Image? image;
  late PainterController painterController;

  @override
  void initState() {
    super.initState();
    painterController = PainterController()
      ..setStrokeColor(ThemeColors.gruvDark)
      ..setMinStrokeWidth(3)
      ..setMaxStrokeWidth(3)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.pencil)
      ..setBlendMode(ui.BlendMode.srcOver);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Painter(
          controller: painterController,
          backgroundColor: Colors.transparent,
          onDrawingEnded: (bytes) async {
            setState(() {});
          },
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        ),
      ],
    );
  }
}

class HandWritingControls extends StatefulWidget {
  final PainterController? pc;
  final Uint8List? imgBytesList;

  const HandWritingControls({
    Key? key,
    this.pc,
    this.imgBytesList,
  }) : super(key: key);

  @override
  State<HandWritingControls> createState() => _ControlsState();
}

class _ControlsState extends State<HandWritingControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        // Colors, background & delete
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              backgroundColor: ThemeColors.gruvDark,
              onPressed: () => {
                widget.pc?.setStrokeColor(ThemeColors.gruvDark),
                widget.pc?.setBlendMode(ui.BlendMode.srcOver)
              },
            ),
            FloatingActionButton(
                backgroundColor: ThemeColors.gruvLight,
                onPressed: () => {
                      widget.pc?.setStrokeColor(ThemeColors.gruvLight),
                      widget.pc?.setBlendMode(ui.BlendMode.dstOut)
                    }),
            FloatingActionButton(
                backgroundColor: ThemeColors.gruvRed,
                child: const Icon(Icons.delete_outline),
                onPressed: () =>
                    widget.pc?.clearContent(clearColor: ThemeColors.gruvLight)),
          ],
        ),
      ],
    );
  }
}
