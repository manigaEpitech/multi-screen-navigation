// Détection automatique du type d'image (Fichier local ou URL Internet)
import 'dart:io';

import 'package:flutter/material.dart';

class BuildRecipeImage extends StatelessWidget {
  final String path;
  final double height;
  const BuildRecipeImage({
    super.key,
    required this.path,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
        cacheWidth: 300,
      );
    } else if (File(path).existsSync()) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
      );
    } else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
      );
    }
  }
}
