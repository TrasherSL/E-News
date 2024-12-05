import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Dark Mode Toggle
          SwitchListTile(
            title: Text("Dark Mode"),
            subtitle: Text("Enable dark theme"),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleTheme(value);
            },
          ),
          // Notifications Toggle
          SwitchListTile(
            title: Text("Notifications"),
            subtitle: Text("Enable app notifications"),
            value: themeProvider.notificationsEnabled,
            onChanged: (bool value) {
              themeProvider.toggleNotifications(value);
              if (value) {
                // Enable notifications (example: show toast or trigger functionality)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Notifications Enabled")),
                );
              } else {
                // Disable notifications
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Notifications Disabled")),
                );
              }
            },
          ),
          // About App Section
          ListTile(
            title: Text("About App"),
            subtitle: Text("Version 1.0.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "News App",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2024 News App Inc.",
              );
            },
          ),
        ],
      ),
    );
  }
}