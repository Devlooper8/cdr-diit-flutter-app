import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes.controller.dart';

class DrawerController extends GetxController {
  var selectedWebsite = 'cdr'.obs;
  var isUserInteracting = false.obs;
  final ThemeController themeController = Get.find();

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
    themeController.toggleTheme();
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