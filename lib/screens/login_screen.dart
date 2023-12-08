import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                RoundedTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                SizedBox(
                    height:
                        10), // Add a small space between password field and forgot password
                TextButton(
                  onPressed: () {
                    // Add logic to handle forgot password, e.g., show a reset password dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Add a dialog to handle password reset
                        return AlertDialog(
                          title: Text('Forgot Password'),
                          content:
                              Text('Enter your email to reset your password.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Implement logic to send a reset password email
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Send Email'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Login',
                  icon: Icons.login,
                  onPressed: () {
                    // Implement login logic here
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
