import 'package:cdr_app/routes/article_page.dart';
import 'package:cdr_app/routes/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String articlePage = '/articlePage';
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        throw const FormatException("Route not found");
    }
  }
}
class RouteException implements Exception {
  final String message;
  const RouteException( this.message);
}