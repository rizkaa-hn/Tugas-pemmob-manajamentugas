import 'package:flutter/material.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn( {
    super.key, this.width, this.hieght, required this.text, 
    this.onTap, required this.color, this.color2,
  });

  final double? width;
  final double? hieght;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: hieght,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 1, color: color),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(18, color, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
