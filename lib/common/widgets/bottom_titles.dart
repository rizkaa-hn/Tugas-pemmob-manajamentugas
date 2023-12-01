import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';
import 'package:todo_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_notifier.dart';

class BottomTitles extends StatefulWidget {
  const BottomTitles({super.key, this.clr, required this.text, required this.text2});
  final Color? clr;
  final String text;
  final String text2;

  @override
  State<BottomTitles> createState() => _BottomTitlesState();
}

class _BottomTitlesState extends State<BottomTitles> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                      color: widget.clr ??
                          ref.read(todosNotifierProvider.notifier).getRandomColor(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                );
              },
            ),
            const WidthSpacer(width: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                      text: widget.text,
                      style: appstyle(24, AppConst.kLight, FontWeight.bold)),
                  const HeightSpacer(size: 10),
                  ReusableText(
                      text: widget.text2,
                      style: appstyle(12, Colors.white54, FontWeight.normal))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
