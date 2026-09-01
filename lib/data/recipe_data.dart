import '../models/recipe.dart';

List<Recipe> dataRecipes = [
  Recipe(
    id: '1',
    title: 'Pâtes Carbonara',
    category: 'Plat',
    imageUrl: 'assets/images/poulet.jpg',
    duration: 20,
    ingredients: ['Pâtes', 'Lardons', 'Jaune d\'œuf', 'Parmesans'],
    steps: [
      'Cuire les pâtes.',
      'Faire griller les lardons.',
      'Mélanger le tout avec l\'œuf et le fromage.',
    ],
  ),
  Recipe(
    id: '2',
    title: 'Mousse au Chocolat',
    category: 'Dessert',
    imageUrl: 'assets/images/poisson.jpg',
    duration: 15,
    ingredients: ['Chocolat noir', 'Œufs', 'Beurre'],
    steps: [
      'Fondre le chocolat.',
      'Monter les blancs en neige.',
      'Incorporer délicatement.',
    ],
  ),
];
