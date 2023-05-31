import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_tpm_123200068/model/meal.dart';
import 'package:responsi_tpm_123200068/pages/detailmeal_page.dart';

class ListMealPage extends StatefulWidget {
  String categoryName;

  ListMealPage({super.key, required this.categoryName});

  @override
  State<ListMealPage> createState() => _ListMealPageState();
}

class _ListMealPageState extends State<ListMealPage> {
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() {
    http
        .get(Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categoryName}'))
        .then((response) {
      if (response.statusCode == 200) {
        var mealsMap = jsonDecode(response.body);
        var mealList = mealsMap['meals'];
        setState(() {
          meals = List<Meal>.from(mealList.map((x) => Meal.fromJson(x)));
        });
      } else {
        throw Exception('Failed to load meals');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Meals'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailMealPage(
                            mealId: meals[index].idMeal!,
                          )))
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 32.0, left: 5.0, right: 5.0),
                  child: ListTile(
                    leading: Image.network(meals[index].strMealThumb!),
                    title: Text(
                      meals[index].strMeal!,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
