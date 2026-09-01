# 🍳 my_cuisine - Application Flutter Multi-Écrans

MiamChef est une application mobile et tablette développée avec Flutter permettant de rechercher, consulter et ajouter des recettes de cuisine. Ce projet a été réalisé dans le cadre de la validation des compétences en développement multi-plateforme et en gestion de la navigation.

##  Fonctionnalités 

Cette application valide l'intégralité des exigences requises par le sujet :

- **Au moins 4 écrans distincts** : 
  - `HomeScreen` : Accueil et catalogue des recettes.
  - `DetailScreen` : Consultation détaillée d'une recette avec ses ingrédients et étapes.
  - `AddRecipeScreen` : Formulaire complet d'ajout de recette.
  - `SettingsScreen` : Gestion des préférences (Thème).
- **Navigation Avancée (`GoRouter`)** : Gestion des itinéraires nommés et passage de paramètres dynamique pour l'écran de détail (`/detail/:id`).
- **Recherche & Filtrage** : Filtrage dynamique en temps réel des recettes depuis l'écran d'accueil via une barre de recherche.
- **Formulaire avec Validation** : Formulaire d'ajout sécurisé comportant plus de 3 champs (`GlobalKey<FormState>`) avec contrôle des données obligatoires et claviers adaptés (numérique pour la durée).
- **Gestion des Thèmes** : Prise en charge native et automatique du **Thème Clair** et **Thème Sombre** (`themeMode: ThemeMode.system`).

## 🛠️ Exigences Techniques Respectées

- **Architecture Propre** : Séparation stricte entre l'interface utilisateur (UI) et les données. Aucune donnée n'est codée en dur dans les vues principales (`lib/data/recipe_data.dart`).
- **Widgets Réutilisables** : Création de composants génériques isolés dans le dossier `widgets/` :
  - `CustomTextField` : Champ de saisie configurable avec gestion des icônes optionnelles et prévention des plantages *Null Safety*.
  - `CustomButton` : Bouton d'action principal harmonisé.
  - `RecipeCard` : Composant visuel pour la grille de présentation.
- **Interface Adaptative** : Utilisation d'un système de grille adaptatif (`GridView.builder`) qui ajuste le nombre de colonnes automatiquement selon la taille de l'écran (2 colonnes sur Mobile, 3 colonnes ou plus sur Tablette).
- **Variété de Widgets** : Utilisation de plus de 8 types de widgets fondamentaux (`Scaffold`, `AppBar`, `GridView`, `ListView`, `Stack`, `Positioned`, `Card`, `TextFormField`, `Expanded`, etc.).
- **Optimisation des Performances** : Mise en cache mémoire de la largeur des images réseau (`cacheWidth`) et intégration d'un `loadingBuilder` pour éviter de bloquer le thread principal au démarrage.

## 📂 Structure du Projet

```text
lib/
│── data/
│   └── recipe_data.dart         # Source de données mockée (Séparation UI/Données)
│── models/
│   └── recipe.dart              # Modèle de données Recipe
│── navigation/
│   └── app_router.dart          # Configuration des routes GoRouter
│── screens/
│   ├── home_screen.dart         # Écran catalogue + Recherche + Adaptabilité
│   ├── detail_screen.dart       # Écran détails avec paramètres
│   ├── add_recipe_screen.dart   # Écran formulaire + validations
│   └── settings_screen.dart     # Écran configuration thème
│── widgets/                     # Composants UI réutilisables
│   ├── custoum_textfield.dart
│   ├── custoum_button.dart
│   └── recipe_card.dart
└── main.dart                    # Point d'entrée de l'application & Configuration Thèmes
```

## 💻 Installation et Lancement

### Prérequis
Assurez-vous d'avoir le SDK Flutter installé et configuré. Vérifiez votre environnement avec la commande :
```bash
flutter doctor
```

### Étape 1 : Cloner le projet et installer les dépendances
```bash
flutter pub get
```

### Étape 2 : Lancer l'application
Pour exécuter l'application en mode développement (Debug) :
```bash
flutter run
```

Pour tester l'application avec les performances réelles de production (mode Profile) :
```bash
flutter run --profile
```
