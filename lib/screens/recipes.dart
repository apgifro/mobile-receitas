import 'package:flutter/material.dart';

import '../models/fetch.dart';
import '../models/recipe.dart';
import '../utils/launch.dart';

class Recipes extends StatefulWidget {
  final String id;
  const Recipes({Key? key, required this.id}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  Map<String, dynamic> fetch = {};
  Recipe? recipe;
  List<String> ingredients = [];

  bool videoUnavailable = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchRecipe(widget.id).then((data) {
      setState(() {
        fetch = data;

        int iterate = 1;
        while (true) {
          try {
            String ingredient = data['meals'][0]['strIngredient$iterate'];
            if (ingredient.isEmpty) {
              break;
            }
            ingredients.add(ingredient);
            iterate = iterate + 1;
          } catch (error) {
            break;
          }
        }

        recipe = Recipe(
            id: data['meals'][0]['idMeal'],
            name: data['meals'][0]['strMeal'],
            instructions: data['meals'][0]['strInstructions']
                .toString()
                .replaceAll('\r\n', '')
                .split('.'),
            urlVideo: data['meals'][0]['strYoutube'],
            ingredients: ingredients!!,
            urlImage: data['meals'][0]['strMealThumb']);

        recipe!.instructions.removeLast();

        if (recipe!.urlVideo.isEmpty) {
          videoUnavailable = !videoUnavailable;
        }
        isLoading = !isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: isLoading ? Text('') : Text(recipe!.name),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Imagem
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(recipe!.urlImage),
                              fit: BoxFit.cover)),
                    ),
                  ),

                  // Ingredientes
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Row(
                      children: const [
                        Text(
                          "Ingredientes",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      scrollDirection: Axis.vertical,
                      itemCount: ingredients?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String ingredient = ingredients![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              const Icon(Icons.blender_outlined,
                                  size: 30, color: Colors.redAccent),
                              const SizedBox(width: 8),
                              Text(
                                ingredient,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        );
                      }),

                  // Instruções
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: Row(
                      children: const [
                        Text(
                          "Instruções",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            final Uri url = Uri.parse(recipe!.urlVideo);
                            launchYoutube(url);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: videoUnavailable
                                  ? Colors.grey
                                  : Colors.redAccent),
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Assistir no YouTube',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      scrollDirection: Axis.vertical,
                      itemCount: recipe!.instructions.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String ingredient = recipe!.instructions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                const SizedBox(width: 15),
                                SizedBox(
                                  width: screenWidth - 90,
                                  child: Text(
                                    ingredient.trim() + '.',
                                    style: const TextStyle(fontSize: 15),
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }
}
