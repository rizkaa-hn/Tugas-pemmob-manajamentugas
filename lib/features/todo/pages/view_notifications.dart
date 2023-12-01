import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';
import 'package:todo_riverpod/common/widgets/width_spacer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var date = payload!.split('|')[2];
    var start = payload!.split('|')[3];
    var end = payload!.split('|')[4];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kHieght * 0.7,
                decoration: const BoxDecoration(
                    color: AppConst.kBackgroundLight,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Reminder",
                          style:
                              appstyle(40, AppConst.kLight, FontWeight.bold)),
                      const HeightSpacer(size: 5),
                      Container(
                        width: AppConst.kWidth ,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                            color: AppConst.kYellow,
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: date.substring(0, 10),
                                style: appstyle(16, AppConst.kBackgroundDark,
                                    FontWeight.w600)),
                            const WidthSpacer(width: 20),
                            ReusableText(
                                text: "From : $start   To : $end",
                                style: appstyle(16, AppConst.kBackgroundDark,
                                    FontWeight.w600)),
                          ],
                        ),
                      ),
                      const HeightSpacer(size: 10),
                      ReusableText(
                          text: title,
                          style: appstyle(
                              30, AppConst.kBackgroundDark, FontWeight.bold)),
                      const HeightSpacer(size: 10),
                      Text(desc,
                          textAlign: TextAlign.justify,
                          style:
                              appstyle(16, AppConst.kLight, FontWeight.normal))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              top: -10.h,
              child: Image.asset("assets/images/bell.png",width: 80.w,height: 80.h, ),
            ),
            Positioned(
              bottom: -AppConst.kHieght * 0.143,
              left: 0,
              right: 0,
              child: Align(
                child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'assets/images/notification.png',
                      width: AppConst.kWidth * 0.8,
                      height: AppConst.kHieght * 0.6,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
