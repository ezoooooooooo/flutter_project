// settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Settings Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Notification Settings'),
              subtitle: Text('Configure your notification preferences'),
              onTap: () {
                // Handle notification settings
                // You can navigate to a detailed notification settings screen
                // or show a dialog with notification options
                // For now, let's just print a message
                print('Navigate to Notification Settings');
              },
            ),
            ListTile(
              title: Text('Account Settings'),
              subtitle: Text('Manage your account details'),
              onTap: () {
                // Handle account settings
                // You can navigate to a detailed account settings screen
                // or show a dialog with account options
                // For now, let's just print a message
                print('Navigate to Account Settings');
              },
            ),
            // Add more settings as needed
          ],
        ),
      ),
    );
  }
}
