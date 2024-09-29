
import 'package:cdr_app/cdr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) async {
    await GetStorage.init(); // Initialize GetStorage
    runApp(const Cdr());
  });
}
