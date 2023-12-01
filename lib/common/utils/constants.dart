import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// constant values can be accessed and used within the application's code
//to maintain consistency in color schemes or dimensions throughout the app
class AppConst {
  AppConst._();
  // AppConst is declared with the _ private constructor.
  // This means that instances of this class cannot be created from outside the class itself.

  static const Color kBackgroundDark = Color(0xFF2a2b2e);
  static const Color kLight = Color(0xFFFFFFFF);
  static const Color kRed = Color(0xffd80000);
  static const Color kBlueLight = Color(0xFF027EB5);
  static const Color kGreyDark = Color(0xFF707070);
  static const Color kLightGrey = Color(0xFF667781);
  static const Color kGreen = Color(0xFF0AA31E);
  static const Color kYellow = Color(0xFFF9F900);
  static const Color kBackgroundLight = Color(0x58797777);
  static const Color kGreyBackground = Color(0xFF202C33);

  static double kWidth = 375.w;
  static double kHieght = 812.h;
}

List<dynamic> colors = const [
  Color(0xffd80000),
  Color(0xFF027EB5),
  Color(0xFFF50FCF),
  Color(0xFFAC0FF5),
  Color(0xFF0AA31E),
  Color(0xFFF9F900),
];

String updateTitle = "";
String updateDescription = "";
