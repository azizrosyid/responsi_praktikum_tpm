import 'package:flutter/material.dart';
import 'package:responsi_tpm_123200068/model/meal_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher_string.dart';

class DetailMealPage extends StatefulWidget {
  String mealId;
  DetailMealPage({super.key, required this.mealId});

  @override
  State<DetailMealPage> createState() => _DetailMealPageState();
}

class _DetailMealPageState extends State<DetailMealPage> {
  MealDetail mealDetail = MealDetail();

  @override
  void initState() {
    super.initState();
    fetchMealDetail();
  }

  void fetchMealDetail() {
    http
        .get(Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId}'))
        .then((response) {
      if (response.statusCode == 200) {
        var mealsMap = jsonDecode(response.body);
        var mealList = mealsMap['meals'];
        setState(() {
          mealDetail = MealDetail.fromJson(mealList[0]);
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
          title: const Text('Meal Detail'),
          centerTitle: true,
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    if (mealDetail.strMeal == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  mealDetail.strMeal!,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
              Image.network(mealDetail.strMealThumb ?? ''),
              const SizedBox(height: 16),
              Text(
                "Category : ${mealDetail.strCategory ?? ''}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              // make this text align left
              Text("Area : ${mealDetail.strArea ?? ''}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left),
              const SizedBox(height: 16),
              Text(mealDetail.strInstructions ?? '',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify),
              const SizedBox(height: 16),
              Text('Tags : ${mealDetail.strTags ?? ''}'),
              const SizedBox(height: 16),
              buildIngredients(),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  launchUrlString(mealDetail.strYoutube!);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('Liat Video Youtube'),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildIngredients() {
    List<Widget> widgets = [];

    for (var i = 1; i <= mealDetail.ingredients!.length; i++) {
      widgets.add(Text(
          '${mealDetail.ingredients![i - 1]} ${mealDetail.measurements![i - 1]}',
          style: const TextStyle(fontSize: 16)));
    }
    return Column(
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ],
    );
  }
}
