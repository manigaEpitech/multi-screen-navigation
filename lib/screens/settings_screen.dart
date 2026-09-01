import 'package:flutter/material.dart';
import '../widgets/theme_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
    return Scaffold(
      appBar: AppBar(title: Text('Paramettre')),
      body: ValueListenableBuilder(
        valueListenable: themeModeNotifier,
        builder: (context, currentMode, child) {
          return ThemeToggle(
            isDark: Theme.of(context).brightness == Brightness.dark,
            onChanged: (isDark) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isDark ? 'Mode sombre active' : 'Mode clair active',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
