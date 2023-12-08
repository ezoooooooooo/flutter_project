import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  hintText: 'Name',
                  icon: Icons.person,
                ),
                SizedBox(
                    height: 10), // Add spacing between name and email fields
                RoundedTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                RoundedTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Sign Up',
                  icon: Icons.person_add,
                  onPressed: () {
                    // Implement sign-up logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
