import 'dart:convert';
import 'package:http/http.dart' as http;

Future <Map<String, dynamic>> fetchCuisine (String country) async {
  final String url = 'https://www.themealdb.com/api/json/v1/1/filter.php?a=$country';
  final http.Response response = await http.get(Uri.parse(url));
  return json.decode(response.body) ;
}

Future <Map<String, dynamic>> fetchRecipe (String id) async {
  final String url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id';
  final http.Response response = await http.get(Uri.parse(url));
  return json.decode(response.body) ;
}