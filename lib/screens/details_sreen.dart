import 'package:flutter/material.dart';
import '../data/recipe_data.dart';
import '../widgets/custom_image.dart';

class DetailScreen extends StatelessWidget {
  final String recipeId;
  const DetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = recipeRepository.findById(recipeId);
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette non trouvée')),
        body: const Center(child: Text('Recette non trouvée')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildRecipeImage(path: recipe.imageUrl, height: 250),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.orange),
                      SizedBox(width: 5),
                      Text(
                        '${recipe.duration} mins',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(width: 15),
                      Chip(
                        label: Text(recipe.category),
                        backgroundColor: Colors.orange.shade100,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Ingrediants',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  ...recipe.ingredients.map(
                    (ingredient) => ListTile(
                      leading: Icon(Icons.lens, size: 10),
                      title: Text(ingredient),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text('Etapes', style: Theme.of(context).textTheme.titleLarge),
                  ...recipe.steps.map(
                    (step) => ListTile(
                      leading: CircleAvatar(
                        radius: 10,
                        child: Text(
                          '${recipe.steps.indexOf(step) + 1}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                      title: Text(step),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
