import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_taking/components/card.dart';
import 'package:note_taking/theme.dart';

class SlidableComponent extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final Function() onTap;
  final Function(BuildContext) onDelete;

  const SlidableComponent({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        openThreshold: 0.15,
        children: [
          SlidableAction(
            onPressed: onDelete,
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
        onTap: onTap,
      ),
    );
  }
}
