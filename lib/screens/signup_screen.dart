import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';
import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RoundedTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  icon: Icons.person,
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                RoundedTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Sign Up',
                  icon: Icons.person_add,
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Validate email using regex
                    if (!isValidEmail(email)) {
                      showErrorMessage(context, 'Invalid email format');
                      return;
                    }

                    // Validate password using custom rules
                    if (!isValidPassword(password)) {
                      showErrorMessage(
                          context, 'Password must be at least 6 characters');
                      return;
                    }

                    try {
                      // Create user in Firebase Authentication
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Check if signup was successful
                      if (userCredential.user != null) {
                        // If signup is successful, navigate to the home screen
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        showErrorMessage(context, 'Signup failed');
                      }
                    } catch (e) {
                      // Handle signup errors
                      showErrorMessage(context, 'Signup failed: $e');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool isValidEmail(String email) {
    // Replace with your preferred email regex
    String emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Replace with your preferred password rules
    return password.length >= 6;
  }
}
