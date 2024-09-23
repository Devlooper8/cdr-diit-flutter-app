import 'package:cdr_app/screens/article/article.controller.dart';
import 'package:cdr_app/screens/article/article.screen.dart';
import 'package:cdr_app/screens/home/home.controller.dart';
import 'package:cdr_app/screens/home/home.screen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(
    name: '/',
    page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeScreenController>(() => HomeScreenController());
      })
  ),
  GetPage(
    name: '/article',
    page: () => const ArticleScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut<ArticleScreenController>(() => ArticleScreenController());
    }),
  ),
/*
  GetPage(
      name: '/bookmarks',
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInController>(() => SignInController());
      })),
  */
];