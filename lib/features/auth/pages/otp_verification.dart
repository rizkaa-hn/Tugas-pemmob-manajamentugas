import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/features/auth/controllers/auth_controller.dart';

class OtpVerification extends ConsumerWidget {
  OtpVerification({
    super.key,
    required this.smsCodeId,
    required this.phone,
  });

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtpCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  final TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppConst.kBackgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSpacer(size: AppConst.kHieght * 0.15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                "assets/images/todo.png",
                width: AppConst.kWidth * 0.5,
              ),
            ),
            const HeightSpacer(size: 26),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
              onSubmitted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
            ),
            const HeightSpacer(size: 26),
          ],
        ),
      )),
    );
  }
}
