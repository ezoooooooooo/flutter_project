import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final bool isPassword; // Add a property to identify password field

  RoundedTextField({
    this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false, // Default is not a password field
  });

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && !isPasswordVisible,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.isPassword) // Add condition for password field
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
        ],
      ),
    );
  }
}
