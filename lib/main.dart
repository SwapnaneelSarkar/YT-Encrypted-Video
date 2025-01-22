import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/color_constant.dart';
import 'router/router.dart';
import 'screens/screen 1/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
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
        initialRoute: Routes.first,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
