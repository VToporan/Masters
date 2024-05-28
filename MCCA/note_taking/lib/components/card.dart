import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class CardComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function() onTap;

  const CardComponent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: ThemeColors.gruvDark,
                ),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.end,
              ),
              subtitle: Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: ThemeColors.gruvDark,
                ),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
