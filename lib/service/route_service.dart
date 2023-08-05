import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pumpit/screen/auth/login_screen.dart';
import 'package:pumpit/screen/home/home_screen.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return CupertinoPageRoute(builder: (_) {
          return const LoginScreen();
        });
      case '/home':
        return CupertinoPageRoute(builder: (_) {
          return const HomeScreen();
        });

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
      );
    });
  }
}
