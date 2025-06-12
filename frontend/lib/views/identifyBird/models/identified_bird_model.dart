class IdentifiedBirdModel {
  final int id;
  final String name;
  final String scientificName;
  final String imageUrl;

  IdentifiedBirdModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.scientificName,
  });
  factory IdentifiedBirdModel.fromJson(Map<String, dynamic> json) {
    return IdentifiedBirdModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      scientificName: json['scientificName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'scientificName': scientificName,
    };
  }
}
