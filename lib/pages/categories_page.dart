import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_tpm_123200068/model/category.dart';
import 'package:responsi_tpm_123200068/pages/listmeal_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() {
    http
        .get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var categoriesJson = response.body;
        var categoriesMap = jsonDecode(categoriesJson);
        var categoryList = categoriesMap['categories'];
        setState(() {
          categories = List<Category>.from(
              categoryList.map((x) => Category.fromJson(x)));
        });
      } else {
        throw Exception('Failed to load categories');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Categories'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListMealPage(
                          categoryName: categories[index].strCategory!)))
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 32.0, left: 5.0, right: 5.0),
                  child: ListTile(
                    leading: Image.network(categories[index].strCategoryThumb!),
                    title: Text(
                      categories[index].strCategory!,
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
