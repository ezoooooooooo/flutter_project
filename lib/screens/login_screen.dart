import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Forgot Password'),
                          content:
                              Text('Enter your email to reset your password.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement logic to send a reset password email
                                showSuccessMessage(
                                    context, 'Password reset email sent');
                                Navigator.pop(context);
                              },
                              child: Text('Send Email'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Login',
                  icon: Icons.login,
                  onPressed: () {
                    String email =
                        ''; // Replace with the actual code to retrieve email

                    if (email.contains(' ')) {
                      showErrorMessage(
                          context, 'Email should not contain spaces');
                    } else {
                      // Proceed with login logic
                      // Implement login logic here
                      showSuccessMessage(context, 'Successfully logged in');
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

  void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
