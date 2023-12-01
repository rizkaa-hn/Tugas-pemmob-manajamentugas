import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/custom_outline_btn.dart';
import 'package:todo_riverpod/common/widgets/custom_textfield.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';
import 'package:todo_riverpod/common/widgets/show_alert_dialog.dart';
import 'package:todo_riverpod/features/auth/controllers/auth_controller.dart';
import 'package:todo_riverpod/features/todo/controllers/code_provider.dart';

class LoginPod extends ConsumerStatefulWidget {
  const LoginPod({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPodState();
}

class _LoginPodState extends ConsumerState<LoginPod> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController countryCode = TextEditingController();


  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter  your number");
    } else if (phone.text.length < 8) {
      return showAlertDialog(
          context: context, message: "Phone number too short");
    }
    ref.read(authControllerProvider).sendSmsCode(
        context: context, phone: '+${ref.read(countryCodeProvider).phoneCode}${phone.text}');
  }

  @override
  Widget build(BuildContext context) {
    var country = ref.watch(countryCodeProvider);
    return Scaffold(
      backgroundColor: AppConst.kBackgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: 300,
                ),
              ),
              const HeightSpacer(size: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.w),
                child: ReusableText(
                    text: "Please enter your number to get verification code",
                    style: appstyle(17, AppConst.kLight, FontWeight.w500)),
              ),
              const HeightSpacer(size: 20),
              Center(
                child: CustomTextField(
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(14),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              countryListTheme: CountryListThemeData(
                                  backgroundColor: AppConst.kBackgroundDark,
                                  bottomSheetHeight: AppConst.kHieght * 0.6,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )),
                              context: context,
                              onSelect: (code) {
                                ref.read(countryCodeProvider.notifier)
                                    .setCountry(code);
                               
                              });
                        },
                        child: ReusableText(
                            text: "${country.flagEmoji} + ${country.phoneCode}",
                            style: appstyle(
                                18, AppConst.kBackgroundDark, FontWeight.bold)),
                      ),
                    ),
                    keyboard: TextInputType.phone,
                    hintText: "Enter your phone number",
                    controller: phone,
                    hintStyle: appstyle(
                        16, AppConst.kBackgroundDark, FontWeight.w600)),
              ),
              const HeightSpacer(size: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomOutlineBtn(
                    onTap: () {
                      sendCodeToUser();
                    },
                    width: AppConst.kWidth * 0.9,
                    hieght: AppConst.kHieght * 0.07,
                    color2: AppConst.kLight,
                    text: "Send Code",
                    color: AppConst.kBackgroundDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
