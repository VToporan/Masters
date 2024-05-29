import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';
import 'package:thumbnailer/thumbnailer.dart';

class CardComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageString;
  final Function() onTap;

  const CardComponent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ThemeColors.gruvLight,
        shadowColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            width: 2,
            color: ThemeColors.gruvDark,
          ),
        ),
        borderOnForeground: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: (imageString != "")
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeColors.gruvDark,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Thumbnail(
                        mimeType: 'image',
                        widgetSize: 100,
                        dataResolver: () async {
                          return base64Decode(imageString);
                        },
                      ))
                  : null,
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: ThemeColors.gruvDark,
                ),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: ThemeColors.gruvDark,
                ),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
