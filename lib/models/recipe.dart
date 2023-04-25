class Recipe {
  final String id;
  final String name;
  final List<String> instructions;
  final String urlImage;
  final String urlVideo;
  final List<String> ingredients;

  const Recipe({
    required this.id,
    required this.name,
    required this.instructions,
    required this.urlImage,
    required this.urlVideo,
    required this.ingredients,
  });
}