
import 'package:cdr_app/cdr.dart';
import 'package:cdr_app/themes.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) async {
    await GetStorage.init();
    Get.put(ThemeController());
    runApp(const Cdr());
  });
}
