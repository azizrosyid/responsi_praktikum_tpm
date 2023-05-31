class MealDetail {
  String? idMeal;
  String? strMeal;
  String? strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  List<String>? ingredients;
  List<String>? measurements;
  String? strSource;
  String? strImageSource;
  String? strCreativeCommonsConfirmed;
  String? dateModified;

  MealDetail({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.ingredients,
    this.measurements,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measurements = [];

    for (int i = 1; i <= 20; i++) {
      final ingredientKey = 'strIngredient$i';
      final measureKey = 'strMeasure$i';

      final ingredient = json[ingredientKey] as String?;
      final measure = json[measureKey] as String?;

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      }

      if (measure != null && measure.isNotEmpty) {
        measurements.add(measure);
      }
    }

    return MealDetail(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients.isNotEmpty ? ingredients : null,
      measurements: measurements.isNotEmpty ? measurements : null,
      strSource: json['strSource'],
      strImageSource: json['strImageSource'],
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }
}
