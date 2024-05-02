import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subTitle;

  CustomCard({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}
