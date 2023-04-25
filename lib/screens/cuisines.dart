import 'package:flutter/material.dart';

import 'package:receitas/models/fetch.dart';
import 'package:receitas/models/cuisine.dart';

class Cuisines extends StatefulWidget {
  final List title;
  const Cuisines({Key? key, required this.title}) : super(key: key);

  @override
  State<Cuisines> createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {
  Map<String, dynamic> fetch = {};
  List<Cuisine>? recipes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchCuisine(widget.title[0]).then((data) {
      setState(() {
        fetch = data;
        for (Map<String, dynamic> meal in fetch['meals']) {
          recipes!.add(Cuisine(
              recipeID: meal['idMeal'],
              recipeName: meal['strMeal'],
              urlRecipeImage: meal['strMealThumb']));
        }
        isLoading = !isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title[1]}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 15.0,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              itemCount: recipes?.length,
              itemBuilder: (BuildContext context, int index) {
                final Cuisine recipe = recipes![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/recipes', arguments: recipe.recipeID);
                  },
                  child: Stack(children: [
                    Container(
                      height: 80 / 100 * screenHeigth,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(recipe.urlRecipeImage),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                        height: 80 / 100 * screenHeigth ,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withAlpha(0),
                              Colors.black12,
                              Colors.black45
                            ],
                          ),
                        ),
                        child: Text(
                          recipe.recipeName,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ))
                  ]),
                );
              }),
    );
  }
}
