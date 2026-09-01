class Recipe {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final int duration;
  final List<String> steps;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.duration,
    required this.steps,
    required this.ingredients,
  });
}
