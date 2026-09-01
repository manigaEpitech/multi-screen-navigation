import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cuisine/widgets/recipe_card.dart';
import '../data/recipe_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    //filtrage des donnees
    final filteredRecipes = dataRecipes
        .where((r) => r.title.toLowerCase().contains(_searchQuery))
        .toList();

    //Adaptatif: calcule du nombre de colonnes selon la largeur de l'ecran(Mobile vs Tablette)
    final double width = MediaQuery.of(context).size.width;
    final int crossAxisCount = width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('MiamChef'),
        actions: [
          IconButton(
            onPressed: () => context.push('/setting'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher une recette ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),

              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return RecipeCard(
                    onTap: () => context.push('/detail/${recipe.id}'),
                    recipe: recipe,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: Icon(Icons.add),
      ),
    );
  }
}

// extension on IconData {
//   get icon => Icon(this);
// }
