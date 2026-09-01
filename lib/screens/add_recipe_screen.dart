import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custoum_textfield.dart';
import '../widgets/custoum_button.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  List<String> _steps = [];
  List<String> _ingrediants = [];
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _duration = TextEditingController();
  final _category = TextEditingController();
  final _imageUrl = TextEditingController();
  final _step = TextEditingController();
  final _ingredient = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recette ajoutee avec succes !'),
          showCloseIcon: true,
        ),
      );
      context.pop();
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _category.dispose();
    _duration.dispose();
    _ingredient.dispose();
    _step.dispose();
    _imageUrl.dispose();

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
            shrinkWrap: true,

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
              CustomTextField(
                labelText: 'Category de la recette',
                controller: _category,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une categorie';
                  }
                  return null;
                },
                icon: (Icons.category),
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Duree de la recette',
                controller: _duration,
                icon: (Icons.timer),
                textInputType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Ingredients de la recette',
                      controller: _ingredient,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un ingredient';
                        }
                        return null;
                      },
                      icon: (Icons.add_shopping_cart_sharp),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      _ingrediants.add(_ingredient.text),
                      _ingredient.clear(),
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Etape de la recette',
                      controller: _step,
                      icon: (Icons.add_shopping_cart_sharp),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une etape';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => {_steps.add(_step.text), _step.clear()},
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Image de la recette',
                controller: _imageUrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une image';
                  }
                  return null;
                },
                icon: Icons.add_to_photos_sharp,
              ),
              SizedBox(height: 15),
              CustomButton(label: 'Sauvegarder', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
