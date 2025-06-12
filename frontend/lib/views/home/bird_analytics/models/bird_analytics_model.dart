class BirdAnalyticsModel {
  String name;
  String scientificName;
  List<String> images;
  String time;
  String location;
  String confidenceLevel;
  List<String> tags; // safe for plants, not toxic

  // overview tab's info
  List<String> quickFacts;
  String rarityType;
  String rarityDesc;
  String description;
  List<OverallRarityModel> overallRarityList;
  List<String> sounds;
  List<FoodModel> foodList;
  List<FeederModel> feederList;
  String distributionArea;

  // features tab's info
  List<String> identificationMarksList;
  List<PhysicalCharacteristicsModel> physicalCharacteristics;
  BehavioralTaitsModel behavioralTaits;
  NestingReproductionModel nestingReproduction;

  // more tab's info
  List<ConservationRemindersModel> conservationReminders;
  List<ScientificClassificationModel> scientificClassification;
  List<SimilarSpeciesModel> similarSpeciesList;
  String facts; // did you know?

  BirdAnalyticsModel({
    required this.name,
    required this.scientificName,
    required this.images,
    required this.time,
    required this.location,
    required this.confidenceLevel,
    required this.tags,
    required this.quickFacts,
    required this.rarityType,
    required this.rarityDesc,
    required this.description,
    required this.overallRarityList,
    required this.sounds,
    required this.foodList,
    required this.feederList,
    required this.distributionArea,
    required this.identificationMarksList,
    required this.physicalCharacteristics,
    required this.behavioralTaits,
    required this.nestingReproduction,
    required this.conservationReminders,
    required this.scientificClassification,
    required this.similarSpeciesList,
    required this.facts,
  });
  factory BirdAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return BirdAnalyticsModel(
      name: json['name'],
      scientificName: json['scientificName'],
      images: List<String>.from(json['images']),
      time: json['time'],
      location: json['location'],
      confidenceLevel: json['confidenceLevel'],
      tags: List<String>.from(json['tags']),
      quickFacts: List<String>.from(json['quickFacts']),
      rarityType: json['rarityType'],
      rarityDesc: json['rarityDesc'],
      description: json['description'],
      overallRarityList:
          (json['overallRarityList'] as List)
              .map((e) => OverallRarityModel.fromJson(e))
              .toList(),
      sounds: List<String>.from(json['sounds']),
      foodList:
          (json['foodList'] as List).map((e) => FoodModel.fromJson(e)).toList(),
      feederList:
          (json['feederList'] as List)
              .map((e) => FeederModel.fromJson(e))
              .toList(),
      distributionArea: json['distributionArea'],
      identificationMarksList: List<String>.from(
        json['identificationMarksList'],
      ),
      physicalCharacteristics:
          (json['physicalCharacteristics'] as List)
              .map((e) => PhysicalCharacteristicsModel.fromJson(e))
              .toList(),
      behavioralTaits: BehavioralTaitsModel.fromJson(json['behavioralTaits']),
      nestingReproduction: NestingReproductionModel.fromJson(
        json['nestingReproduction'],
      ),
      conservationReminders:
          (json['conservationReminders'] as List)
              .map((e) => ConservationRemindersModel.fromJson(e))
              .toList(),
      scientificClassification:
          (json['scientificClassification'] as List)
              .map((e) => ScientificClassificationModel.fromJson(e))
              .toList(),
      similarSpeciesList:
          (json['similarSpeciesList'] as List)
              .map((e) => SimilarSpeciesModel.fromJson(e))
              .toList(),
      facts: json['facts'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'scientificName': scientificName,
      'images': images,
      'time': time,
      'location': location,
      'confidenceLevel': confidenceLevel,
      'tags': tags,
      'quickFacts': quickFacts,
      'rarityType': rarityType,
      'rarityDesc': rarityDesc,
      'description': description,
      'overallRarityList': overallRarityList.map((e) => e.toJson()).toList(),
      'sounds': sounds,
      'foodList': foodList.map((e) => e.toJson()).toList(),
      'feederList': feederList.map((e) => e.toJson()).toList(),
      'distributionArea': distributionArea,
      'identificationMarksList': identificationMarksList,
      'physicalCharacteristics':
          physicalCharacteristics.map((e) => e.toJson()).toList(),
      'behavioralTaits': behavioralTaits.toJson(),
      'nestingReproduction': nestingReproduction.toJson(),
      'conservationReminders':
          conservationReminders.map((e) => e.toJson()).toList(),
      'scientificClassification':
          scientificClassification.map((e) => e.toJson()).toList(),
      'similarSpeciesList': similarSpeciesList.map((e) => e.toJson()).toList(),
      'facts': facts,
    };
  }
}

class PhysicalCharacteristicsModel {
  String title;
  String value;
  PhysicalCharacteristicsModel({required this.title, required this.value});
  factory PhysicalCharacteristicsModel.fromJson(Map<String, dynamic> json) {
    return PhysicalCharacteristicsModel(
      title: json['title'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'value': value};
}

class BehavioralTaitsModel {
  List<String> traits;
  String seasonalAppearance;
  String diet;
  BehavioralTaitsModel({
    required this.traits,
    required this.seasonalAppearance,
    required this.diet,
  });
  factory BehavioralTaitsModel.fromJson(Map<String, dynamic> json) {
    return BehavioralTaitsModel(
      traits: List<String>.from(json['traits']),
      seasonalAppearance: json['seasonalAppearance'],
      diet: json['diet'],
    );
  }

  Map<String, dynamic> toJson() => {
    'traits': traits,
    'seasonalAppearance': seasonalAppearance,
    'diet': diet,
  };
}

class NestingReproductionModel {
  String breedingSeason;
  String nest;
  String eggs;
  String fledging;
  NestingReproductionModel({
    required this.breedingSeason,
    required this.nest,
    required this.eggs,
    required this.fledging,
  });
  factory NestingReproductionModel.fromJson(Map<String, dynamic> json) {
    return NestingReproductionModel(
      breedingSeason: json['breedingSeason'],
      nest: json['nest'],
      eggs: json['eggs'],
      fledging: json['fledging'],
    );
  }

  Map<String, dynamic> toJson() => {
    'breedingSeason': breedingSeason,
    'nest': nest,
    'eggs': eggs,
    'fledging': fledging,
  };
}

class OverallRarityModel {
  String label;
  String title;
  String rarity;

  OverallRarityModel({
    required this.label,
    required this.title,
    required this.rarity,
  });
  factory OverallRarityModel.fromJson(Map<String, dynamic> json) {
    return OverallRarityModel(
      label: json['label'],
      title: json['title'],
      rarity: json['rarity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'title': title,
    'rarity': rarity,
  };
}

class FoodModel {
  String image;
  String name;
  FoodModel({required this.image, required this.name});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(image: json['image'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'image': image, 'name': name};
}

class FeederModel {
  String image;
  String name;
  FeederModel({required this.image, required this.name});
  factory FeederModel.fromJson(Map<String, dynamic> json) {
    return FeederModel(image: json['image'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'image': image, 'name': name};
}

class ConservationRemindersModel {
  String title;
  String description;
  ConservationRemindersModel({required this.title, required this.description});
  factory ConservationRemindersModel.fromJson(Map<String, dynamic> json) {
    return ConservationRemindersModel(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}

class ScientificClassificationModel {
  String title;
  String description;
  ScientificClassificationModel({
    required this.title,
    required this.description,
  });
  factory ScientificClassificationModel.fromJson(Map<String, dynamic> json) {
    return ScientificClassificationModel(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}

class SimilarSpeciesModel {
  int id;
  String name;
  String scientificName;
  String description;
  String image;
  SimilarSpeciesModel({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.image,
  });
  factory SimilarSpeciesModel.fromJson(Map<String, dynamic> json) {
    return SimilarSpeciesModel(
      id: json['id'],
      name: json['name'],
      scientificName: json['scientificName'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'scientificName': scientificName,
    'description': description,
    'image': image,
  };
}
