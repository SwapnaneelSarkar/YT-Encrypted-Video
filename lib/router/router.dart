import 'package:flutter/material.dart';
import '../screens/screen 1/view.dart';
import '../screens/screen 2/view.dart';

class Routes {
  static const String first = '/first';
  static const String second = '/second';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.first:
        return MaterialPageRoute(builder: (_) => FirstScreen());

      case Routes.second:
        return MaterialPageRoute(builder: (_) => SecondPage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            "Page Not Found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
