import 'package:flutter/material.dart';
import 'constants/color_constant.dart';
import 'router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Futuristic App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorConstant.primaryColor,
        colorScheme: ColorScheme.dark(
          primary: ColorConstant.primaryColor,
          secondary: ColorConstant.accentColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorConstant.inputFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorConstant.borderColor),
          ),
        ),
      ),
      initialRoute: AppRouter.firstScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
