import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;

  RoundedTextField(
      {this.controller, required this.hintText, required this.icon});

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
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
