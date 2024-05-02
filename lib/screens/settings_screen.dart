import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatelessWidget {
  Future<void> updateName(BuildContext context, String newName) async {
    try {
      var response = await http.patch(
        Uri.parse('http://localhost:3000/api/user/name'),
        body: {
          'name': newName,
        },
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Name updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update name: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update name: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> updatePassword(BuildContext context, String newPassword) async {
    try {
      var response = await http.patch(
        Uri.parse('http://localhost:3000/api/user/password'),
        body: {
          'password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update password: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update password: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      var response = await http.delete(
        Uri.parse('http://localhost:3000/api/user/delete'),
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete account: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                updateName(context, 'New Name');
              },
              child: Text('Update Name'),
            ),
            ElevatedButton(
              onPressed: () {
                updatePassword(context, 'New Password');
              },
              child: Text('Update Password'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteAccount(context);
              },
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
