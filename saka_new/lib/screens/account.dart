import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.person), // User icon
            title: Text('John Doe'),
            subtitle: Text('johndoe@example.com'),
          ),
          const Divider(), // Divider line
          ListTile(
            leading: Icon(Icons.lock), // Lock icon
            title: const Text('Change Password'),
            onTap: () {
              // Handle change password action
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications), // Notifications icon
            title: const Text('Notification Settings'),
            onTap: () {
              // Handle notification settings action
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Logout icon
            title: const Text('Log Out'),
            onTap: () {
              // Handle logout action
            },
          ),
        ],
      ),
    );
  }
}
