import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/custom_outline_btn.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/features/auth/pages/signin.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHieght,
      width: AppConst.kWidth,
      color: AppConst.kBackgroundDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(
              "assets/images/todo.png",
            ),
          ),
          const HeightSpacer(size: 50),
          CustomOutlineBtn(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPod()));
              },
              width: AppConst.kWidth * 0.9,
              hieght: AppConst.kHieght * 0.06,
              color2: AppConst.kLight,
              text: "Login in with phone number",
              color: AppConst.kBackgroundDark),
        ],
      ),
    );
  }
}
