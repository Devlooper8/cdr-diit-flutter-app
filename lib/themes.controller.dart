// theme_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    bool? storedIsDarkMode = box.read('isDarkMode');
    if (storedIsDarkMode != null) {
      isDarkMode.value = storedIsDarkMode;
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    } else {
      isDarkMode.value = Get.isDarkMode;
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    box.write('isDarkMode', isDarkMode.value);
  }
}
