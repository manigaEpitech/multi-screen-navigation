import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;
  const ThemeToggle({super.key, required this.isDark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Mode Sombre'),
      secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      value: isDark,
      onChanged: onChanged,
    );
  }
}
