import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final dynamic bgColor;
  final IconData iconData;
  CategoryIcon({required this.bgColor, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
