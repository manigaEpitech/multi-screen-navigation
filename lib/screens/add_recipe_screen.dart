import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import '../models/recipe.dart';
import '../data/recipe_data.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _dynamicInputController = TextEditingController();

  final List<String> _categories = ['Plat', 'Entrée', 'Dessert', 'Apéritif'];
  String _selectedCategory = 'Plat';

  final List<String> _ingredients = [];
  final List<String> _steps = [];

  // Variables pour la gestion de la vraie image
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Fonction pour sélectionner l'image depuis la galerie
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth:
          800, // Limite la taille pour optimiser la mémoire (évite le lag)
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Sauvegarde permanente du fichier dans le stockage local de l'application
  Future<String> _saveImagePermanently(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName =
        'recipe_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File localImage = await imageFile.copy('${directory.path}/$fileName');
    return localImage.path; // Retourne le chemin local absolu
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_ingredients.isEmpty || _steps.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Veuillez ajouter au moins un ingrédient et une étape !',
            ),
          ),
        );
        return;
      }

      String finalImagePath = 'assets/images/poisson.jpg'; // Image par défaut

      // Si l'utilisateur a sélectionné une vraie image, on la sauvegarde localement
      if (_selectedImage != null) {
        finalImagePath = await _saveImagePermanently(_selectedImage!);
      }

      final newRecipe = Recipe(
        id: Random().nextInt(1000).toString(),
        title: _titleController.text,
        category: _selectedCategory,
        duration: int.parse(_durationController.text),
        imageUrl:
            finalImagePath, // Contiendra l'adresse locale du fichier image
        ingredients: _ingredients,
        steps: _steps,
      );

      recipeRepository.addRecipe(newRecipe);
      if (mounted) context.pop();
    }
  }

  void _addToList(List<String> list) {
    if (_dynamicInputController.text.isNotEmpty) {
      setState(() {
        list.add(_dynamicInputController.text);
        _dynamicInputController.clear();
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _dynamicInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une recette')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _titleController,
                labelText: 'Titre de la recette',
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: _durationController,
                labelText: 'Durée (minutes)',
                textInputType: TextInputType.number,
                icon: Icons.timer,
              ),
              const SizedBox(height: 20),

              // SECTION IMAGE MODIFIÉE : Aperçu visuel et bouton de sélection
              Text(
                'Image de la recette',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.black54,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Cliquez pour choisir une image depuis la galerie',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 25),

              Text(
                'Ajout dynamique',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dynamicInputController,
                      decoration: const InputDecoration(
                        labelText: 'Saisir un élément...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton.filled(
                    onPressed: () => _addToList(_ingredients),
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  IconButton.filled(
                    onPressed: () => _addToList(_steps),
                    icon: const Icon(Icons.format_list_numbered),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text('Ingrédients ajoutés :'),
              Wrap(
                spacing: 8,
                children: _ingredients
                    .map(
                      (ing) => Chip(
                        label: Text(ing),
                        onDeleted: () =>
                            setState(() => _ingredients.remove(ing)),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),

              const Text('Étapes ajoutées :'),
              Column(
                children: _steps
                    .map(
                      (st) => ListTile(
                        leading: CircleAvatar(
                          radius: 12,
                          child: Text('${_steps.indexOf(st) + 1}'),
                        ),
                        title: Text(st),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => setState(() => _steps.remove(st)),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 30),
              CustomButton(label: 'Sauvegarder la recette', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
