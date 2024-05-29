import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_taking/components/card.dart';
import 'package:note_taking/theme.dart';

class SlidableComponent extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final String cardImageString;
  final Function() onTap;
  final Function(BuildContext) onDelete;

  const SlidableComponent({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.cardImageString,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Slidable(
        key: key,
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.10,
          openThreshold: 0.05,
          children: [
            SlidableAction(
              onPressed: onDelete,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              backgroundColor: ThemeColors.gruvRed,
              foregroundColor: ThemeColors.gruvLight,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: CardComponent(
          title: cardTitle,
          subTitle: cardSubtitle,
          imageString: cardImageString,
          onTap: onTap,
        ),
      ),
    );
  }
}
