import 'package:flutter/material.dart';
import '../main.dart'; // Importation nécessaire pour accéder à themeNotifier
import '../widgets/theme_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Vérifie si le mode actuel de l'application est sombre
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ThemeToggle(
              isDark: isDark,
              onChanged: (bool value) {
                // Change dynamiquement le mode de l'application
                if (value) {
                  themeNotifier.value = ThemeMode.dark;
                } else {
                  themeNotifier.value = ThemeMode.light;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
