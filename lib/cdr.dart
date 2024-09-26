import 'package:cdr_app/screens/home/home.controller.dart';
import 'package:cdr_app/screens/home/home.screen.dart';
import 'package:cdr_app/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class Cdr extends StatelessWidget {
  const Cdr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        key: Get.nestedKey(0),
        getPages: routes,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<HomeScreenController>(() => HomeScreenController());
        }),
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
        popGesture: false,
        scrollBehavior: const MaterialScrollBehavior()
            .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        title: "CDR.CZ",
        theme: Themes.lightTheme,  // Set the light theme here
        darkTheme: Themes.darkTheme,  // Set the dark theme here
        themeMode: ThemeMode.light,
        // home: const SignInScreen(),
        home: const HomeScreen(),
    );
  }
}