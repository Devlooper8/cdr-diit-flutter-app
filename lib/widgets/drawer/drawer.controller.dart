import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  var selectedWebsite = 'cdr'.obs;
  var isDarkMode = Get.isDarkMode.obs;
  var isUserInteracting = false.obs;

  int get selectedIndex => selectedWebsite.value == 'cdr' ? 0 : 1;

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: selectedIndex);
    super.onInit();
  }

  void switchWebsite(String website) {
    selectedWebsite.value = website;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void setUserInteracting(bool isInteracting) {
    isUserInteracting.value = isInteracting;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
