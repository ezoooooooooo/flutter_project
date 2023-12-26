import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this import is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (e) {
    // Handle initialization error
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  static const String authChoiceRoute = '/auth_choice';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';

  // Initialize an empty list of HousingItem
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Housing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: authChoiceRoute,
      routes: {
        authChoiceRoute: (context) => AuthChoiceScreen(),
        loginRoute: (context) => LoginScreen(),
        signupRoute: (context) => SignUpScreen(),
        homeRoute: (context) => HomeScreen(),
      },
    );
  }

  
 
}

