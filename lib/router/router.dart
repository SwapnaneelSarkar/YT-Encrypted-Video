import 'package:flutter/material.dart';
import '../screens/screen 1/view.dart';
import '../screens/screen 2/view.dart';

class AppRouter {
  static const String firstScreen = '/';
  static const String secondScreen = '/second';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case firstScreen:
        return MaterialPageRoute(builder: (_) => FirstScreen());
      case secondScreen:
        return MaterialPageRoute(
          builder: (_) => SecondPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
