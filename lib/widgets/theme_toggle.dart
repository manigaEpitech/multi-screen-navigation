import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const ThemeToggle({super.key, required this.isDark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: const Text('Mode Sombre'),
        subtitle: Text(
          isDark
              ? 'Désactiver pour le mode clair'
              : 'Activer pour le mode sombre',
        ),
        secondary: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: isDark ? Colors.amber : Colors.grey,
        ),
        value: isDark,
        onChanged: onChanged,
      ),
    );
  }
}
