import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/reusable_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_riverpod/features/onboarding/widgets/page_one.dart';
import 'package:todo_riverpod/features/onboarding/widgets/page_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // page controller lets you manipulate which page is visible in a [PageView]. 
  //In addition to being able to control the pixel offset of the content inside the [PageView]
  final PageController pageController = PageController();

  @override
  void dispose() {
    // Called when this object is removed from the tree permanently.
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Stack(
          // Creates a stack layout widget.
      children: [
        
        // Creates a scrollable list that works page by page from [List] of widgets.
        PageView(
          physics: const AlwaysScrollableScrollPhysics(),
          // How the page view should respond to user input.
          controller: pageController,
          onPageChanged: (page) {},
          // Called whenever the page in the center of the viewport changes.
          children: const [
            // scrollable list that works page by page
            PageOne(),
            PageTwo()],
        ),
        
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            // Creates insets with symmetrical vertical and horizontal offsets.
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // How the children should be placed along the main axis in a flex layout.
              children: [
                GestureDetector(
                  // widget that detects gestures
                  onTap: () {
                    // This triggers when the tap gesture and it returns a void Function()?
                    pageController.jumpToPage(1);
              // Jumps the page position from its current value to the given value, 
              //without animation, and without checking if the new value is in range.
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // How the children should be placed along the cross axis in a flex layout.
                    children: [
                      GestureDetector(
                          onTap: () {
                            pageController.nextPage(
                              // Animates the controlled [PageView] to the next page.
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: const Icon(
                            Ionicons.chevron_forward_circle,
                            size: 30,
                          )),
                      const WidthSpacer(width: 5),
                     
                      ReusableText(
                          text: "Skip",
                          style: appstyle(
                              16, AppConst.kLight, FontWeight.w500)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.ease);
                  },
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                        dotHeight: 12,
                        dotWidth: 16,
                        spacing: 10,
                        dotColor: AppConst.kYellow.withOpacity(0.5),
                        activeDotColor: AppConst.kLight),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
