import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_now_backend/constant/my_theme.dart';

class TabButton extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;

  const TabButton({
    super.key,
    required this.label,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    log("is selected : $isSelected | $index");
    final TabController controller = DefaultTabController.of(context);

    return GestureDetector(
      onTap: () => controller.animateTo(index),
      child: Container(
        width: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: isSelected ? MyTheme.purpleShade1 : Colors.grey.shade300,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}
