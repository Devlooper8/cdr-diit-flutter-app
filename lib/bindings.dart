import 'package:cdr_app/screens/home/home.controller.dart';
import 'package:cdr_app/widgets/drawer/drawer.controller.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(()=>HomeScreenController());
   Get.lazyPut<DrawerController>(() => DrawerController());
  }
}
