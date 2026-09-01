import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../widgets/custom_textfield.dart';
import '../data/recipe_data.dart';
import '../widgets/custom_button.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _duration = TextEditingController();
  final _imageUrl = TextEditingController();
  final _step = TextEditingController();
  final _dynamic = TextEditingController();

  final List<String> _category = [
    'Plat',
    'Entree',
    'Dessert',
    'Boisson',
    'Sauce',
    'Autre',
    'Apéritif',
  ];
  String _selectedCategory = 'Plat';
  final List<String> _ingredients = [];
  final List<String> _steps = [];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_ingredients.isEmpty || _steps.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Veuillez ajouter au moins un ingrédient et une étape.',
            ),
          ),
        );
        return;
      }

      final newRecipe = Recipe(
        id: Random().nextInt(1000).toString(),
        title: _title.text,
        category: _selectedCategory,
        imageUrl: _imageUrl.text.isEmpty
            ? 'https://unsplash.com'
            : _imageUrl.text,
        duration: int.parse(_duration.text),
        ingredients: _ingredients,
        steps: _steps,
      );

      recipeRepository.addRecipe(newRecipe);
      context.pop();
    }
  }

  @override
  void _addToList(List<String> list) {
    if (_dynamic.text.isNotEmpty) {
      setState(() {
        list.add(_dynamic.text);
        _dynamic.clear();
      });
    }
  }

  @override
  void dispose() {
    _title.dispose();

    _duration.dispose();

    _step.dispose();
    _imageUrl.dispose();
    _dynamic.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une recette')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _title,
                labelText: 'Titre de la recette',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              DropdownButtonFormField(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categorie de la recette',
                  border: OutlineInputBorder(),
                ),
                items: _category
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val!;
                  });
                },
              ),
              SizedBox(height: 15),

              CustomTextField(
                labelText: 'Image (optionnel)',
                controller: _imageUrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une image';
                  }
                  return null;
                },
                icon: Icons.image,
              ),
              SizedBox(height: 25),
              CustomTextField(
                labelText: 'Duree de la recette(minutes)',
                controller: _duration,
                icon: (Icons.timer),
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 25),

              Text(
                'Ajout dynamique',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dynamic,
                      decoration: InputDecoration(
                        labelText: 'Ajouter un ingrédient ou une étape',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton.filled(
                    onPressed: () => _addToList(_ingredients),
                    icon: Icon(Icons.shopping_cart),
                  ),
                  IconButton.filled(
                    onPressed: () => _addToList(_steps),
                    icon: Icon(Icons.format_list_numbered),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Text(
                'Ingrédients ajoutés:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 6.0,
                children: _ingredients
                    .map(
                      (ingredient) => Chip(
                        label: Text(ingredient),
                        onDeleted: () {
                          setState(() {
                            _ingredients.remove(ingredient);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              Text(
                'Étapes ajoutées:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),

              Column(
                children: _steps
                    .map(
                      (step) => ListTile(
                        title: Text(step),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _steps.remove(step);
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 30),
              CustomButton(label: 'Sauvegarder', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
