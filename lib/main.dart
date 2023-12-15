import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart'; // Import the HomeScreen
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    runApp(MyApp());
  } catch (e) {
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Housing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/auth_choice',
      routes: {
        '/auth_choice': (context) => AuthChoiceScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(), // Ensure HomeScreen is referenced
      },
    );
  }
}
