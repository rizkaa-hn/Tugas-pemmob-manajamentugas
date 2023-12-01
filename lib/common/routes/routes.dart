import 'package:flutter/material.dart';
import 'package:todo_riverpod/common/models/task.dart';
import 'package:todo_riverpod/features/auth/pages/otp_verification.dart';
import 'package:todo_riverpod/features/auth/pages/signin.dart';
import 'package:todo_riverpod/features/onboarding/onboarding_screen.dart';
import 'package:todo_riverpod/features/todo/pages/add.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';
import 'package:todo_riverpod/features/todo/pages/update.dart';


class Routes {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';
  static const String add = 'add';
  static const String update = 'update';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginPod(),
        );
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => OtpVerification(
            smsCodeId: args['smsCodeId'],
            phone: args['phone'],
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case add:
        return MaterialPageRoute(
          builder: (context) => const AddTask(),
        );
      case update:
        final Task data = settings.arguments as Task;
        return MaterialPageRoute(
          builder: (context) => Update(data: data,),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('No Page Route Provided'),
              ),
            );
          },
        );
    }
  }
}
