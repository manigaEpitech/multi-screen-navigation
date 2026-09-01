import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeRepository extends ChangeNotifier {
  // Liste privée modifiable
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Pâtes Carbonara',
      category: 'Plat',
      imageUrl: 'assets/images/lapin.jpg',
      duration: 20,
      ingredients: ['Pâtes', 'Lardons', 'Jaune d\'œuf', 'Parmesan'],
      steps: ['Cuire les pâtes.', 'Faire griller les lardons.', 'Mélanger.'],
    ),
    Recipe(
      id: '2',
      title: 'Mousse au Chocolat',
      category: 'Dessert',
      imageUrl: 'assets/images/attieke.jpg',
      duration: 15,
      ingredients: ['Chocolat noir', 'Œufs', 'Beurre'],
      steps: ['Fondre le chocolat.', 'Monter les blancs.', 'Incorporer.'],
    ),
  ];

  List<Recipe> get recipes => List.unmodifiable(_recipes);

  // Permet de chercher une recette de manière sécurisée (Résout le problème 9)
  Recipe? findById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners(); // Alerte l'interface UI du changement
  }
}

// Instance globale simple et propre pour le projet
final recipeRepository = RecipeRepository();
