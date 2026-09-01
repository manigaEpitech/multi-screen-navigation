import 'package:flutter/material.dart';
import '../data/recipe_data.dart';

class DetailScreen extends StatelessWidget {
  final String recipeId;
  const DetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = dataRecipes.firstWhere((r) => r.id == recipeId);
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              recipe.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
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
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Ingrediants',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.check_circle_outline),
                      title: Text(recipe.ingredients[index]),
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
