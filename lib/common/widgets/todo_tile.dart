import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';
import 'package:todo_riverpod/common/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
       this.child,
      this.title,
      this.description,
      this.update,
      this.delete,
      this.color,
      this.start,
      this.end, this.editIcon});
  final Widget? child;
  final Widget? editIcon;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final void Function()? update;
  final void Function()? delete;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: AppConst.kWidth,
            decoration: const BoxDecoration(
                color: AppConst.kLightGrey,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                          color: color ?? AppConst.kRed,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                    ),
                    const WidthSpacer(width: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: AppConst.kWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: title ?? 'Get Medication',
                                style: appstyle(
                                    18, AppConst.kLight, FontWeight.bold)),
                            const HeightSpacer(size: 3),
                            ReusableText(
                                text: description ?? "Visit the hospital",
                                style: appstyle(
                                    12, AppConst.kLight, FontWeight.normal)),
                            const HeightSpacer(size: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3, color: AppConst.kGreyDark),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color: AppConst.kBackgroundDark,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                        text: "$start | $end",
                                        style: appstyle(12, AppConst.kLight,
                                            FontWeight.normal)),
                                  ),
                                ),
                               
                                const WidthSpacer(width: 20),
                               
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editIcon,
                                    ),
                                    const WidthSpacer(width: 20),
                                    GestureDetector(
                                        onTap: delete,
                                        child: const Icon(MaterialCommunityIcons
                                            .delete_circle)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 0.h,
                  ),
                  child: child,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
