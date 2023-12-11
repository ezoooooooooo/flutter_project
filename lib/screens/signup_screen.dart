import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_textfield.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  hintText: 'Name',
                  icon: Icons.person,
                ),
                SizedBox(
                  height: 10,
                ),
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
                    String email =
                        ''; // Replace with the actual code to retrieve email

                    if (email.contains(' ')) {
                      showErrorMessage(
                          context, 'Email should not contain spaces');
                    } else {
                      // Proceed with sign-up logic
                      // Implement sign-up logic here
                      showSuccessMessage(context, 'Successfully signed up');
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
