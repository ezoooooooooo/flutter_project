import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                RoundedTextField(
                  controller: _passwordController,
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

                    // Proceed with login logic
                    // Implement login logic here
                    showSuccessMessage(context, 'Successfully logged in');
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

  bool isValidEmail(String email) {
    String emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
