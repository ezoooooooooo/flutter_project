import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Housing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loginRoute,
      routes: {
        loginRoute: (context) => LoginScreen(),
        signupRoute: (context) => SignUpScreen(),
        homeRoute: (context) => HomeScreen(),
      },
    );
  }
}
