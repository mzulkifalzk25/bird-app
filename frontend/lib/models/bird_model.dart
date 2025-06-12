class BirdModel {
  final String title;
  final String scientificName;
  final String imageUrl;
  final String category;
  final String foodType;
  final String feederType;
  final String rarityCategory;
  final String grade;
  final String? dateAdded;

  BirdModel({
    required this.title,
    required this.scientificName,
    required this.imageUrl,
    required this.category,
    required this.foodType,
    required this.feederType,
    required this.rarityCategory,
    required this.grade,
    this.dateAdded,
  });

  factory BirdModel.fromJson(Map<String, dynamic> json) {
    return BirdModel(
      title: json['title'] as String,
      scientificName: json['scientificName'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      foodType: json['foodType'] as String,
      feederType: json['feederType'] as String,
      rarityCategory: json['rarityCategory'] as String,
      grade: json['grade'] as String,
      dateAdded: json['dateAdded'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'scientificName': scientificName,
      'imageUrl': imageUrl,
      'category': category,
      'foodType': foodType,
      'feederType': feederType,
      'rarityCategory': rarityCategory,
      'grade': grade,
      'dateAdded': dateAdded,
    };
  }
}
