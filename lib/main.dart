import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/models/user_model.dart';
import 'package:todo_riverpod/common/routes/routes.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/features/auth/controllers/user_state.dart';
import 'package:todo_riverpod/features/onboarding/onboarding_screen.dart';
import 'package:todo_riverpod/firebase_options.dart';

Widget entrypoint = const OnBoardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // ConsumerWidget || is [StatelessWidget] that can listen to providers.
  const MyApp({super.key});

  static final defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  );

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.read(userProvider);
    return ScreenUtilInit(
        //A helper widget that initializes [ScreenUtil]

        // Set this to true for Flutter 3.10 to avoid keyboard overlay on TextField
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return DynamicColorBuilder(
            // is a stateful widget that provides the device's dynamic colors in a light and dark ColorScheme
            // will be null if dynamic color is not supported on the platform, or if the OS has yet to respond.
            builder: (lightColorScheme, darkColorScheme) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'ToDo',
                  theme: ThemeData(
                    colorScheme: lightColorScheme ?? defaultLightColorScheme,
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                    scaffoldBackgroundColor: AppConst.kBackgroundDark,
                    useMaterial3: true,
                  ),
                  // Determines which theme will be used by the application if both [theme] and [darkTheme] are provided.
                  themeMode: ThemeMode.dark,
                  home: ref.watch(userProvider.notifier).defaultEntry(users),
                  onGenerateRoute: Routes.onGenerateRoute);
            },
          );
        });
  }
}
