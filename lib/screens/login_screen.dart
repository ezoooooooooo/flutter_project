import 'package:flutter/material.dart';
import 'package:studenthousingapp/main.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';
import 'home_screen.dart';


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
                  isPassword: true,
                ),
                SizedBox(height: 10),
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
                              onPressed: () async {
                                String email = _emailController.text;

                               
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
                  Center(
                  child: GestureDetector(
                    onTap: _navigateToSignUpScreen,
                    child: Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Login',
                  icon: Icons.login,
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
  String email = _emailController.text;
  String password = _passwordController.text;
  BuildContext context = _scaffoldKey.currentContext!;

  
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
  void _navigateToSignUpScreen() {
    Navigator.pushReplacementNamed(context, MyApp.signupRoute);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
