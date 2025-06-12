import 'package:bird_discovery/models/bird_model.dart';
import 'package:bird_discovery/views/explore/models/category_item_model.dart';
import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/app_images.dart';

class ExploreModel {
  final String title;
  final String description;

  ExploreModel({required this.title, required this.description});
}

class ExploreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Your initialization code here
    fetchData();
  }

  final _data =
      ExploreModel(
        title:
            'Bird Families, Species, and Habitats. Learn about the different types of birds you can find in your area.',
        description:
            'Discover local species by snapping a photo of a bird or searching by name or family. This app is designed to help you identify birds in your area and learn more about them. As you explore, you can save your favorite birds and share your findings with friends. Whether you are a beginner or an experienced birdwatcher, this app is for you.',
      ).obs;

  final List<CategoryItemModel> allCategories = [];
  final RxList<CategoryItemModel> filteredCategories =
      <CategoryItemModel>[].obs;

  final Rx<CategoryItemModel?> selectedCategory = Rx<CategoryItemModel?>(null);

  final List<BirdModel> allBirds = <BirdModel>[].obs;
  final RxList<BirdModel> filteredBirds = <BirdModel>[].obs;

  final List<FoodModel> foodOptions = [
    FoodModel(name: 'All', image: AppImages.allCategory),
  ];

  final List<FeederModel> feederOptions = [
    FeederModel(name: 'All', image: AppImages.allCategory),
  ];

  Future<void> fetchData() async {
    List<FoodModel> foodTypes = [
      FoodModel(image: AppImages.food1, name: 'Seeds'),
      FoodModel(image: AppImages.food1, name: 'Fruits'),
      FoodModel(image: AppImages.food1, name: 'Insects'),
      FoodModel(image: AppImages.food1, name: 'Nyjer'),
    ];
    List<FeederModel> feederTypes = [
      FeederModel(image: AppImages.feeder1, name: 'Ground'),
      FeederModel(image: AppImages.feeder2, name: 'Platform'),
      FeederModel(image: AppImages.feeder1, name: 'Ground'),
      FeederModel(image: AppImages.feeder2, name: 'Platform'),
    ];

    List<CategoryItemModel> categories = [
      CategoryItemModel(
        title: 'Common Landbirds',
        imageUrl: AppImages.commonbird1,
      ),
      CategoryItemModel(
        title: 'Common Waders',
        imageUrl: AppImages.commonbird2,
      ),
      CategoryItemModel(
        title: 'Common Natators',
        imageUrl: AppImages.commonbird3,
      ),
      CategoryItemModel(
        title: 'Common Songbirds',
        imageUrl: AppImages.commonbird4,
      ),
      CategoryItemModel(
        title: 'Common Raptors',
        imageUrl: AppImages.commonbird5,
      ),
      CategoryItemModel(
        title: 'Common Colorful Birds',
        imageUrl: AppImages.commonbird6,
      ),
      CategoryItemModel(
        title: 'Common Colorful Birds',
        imageUrl: AppImages.commonbird6,
      ),
      CategoryItemModel(
        title: 'Common Colorful Birds',
        imageUrl: AppImages.commonbird6,
      ),
    ];

    allCategories.assignAll(categories);
    foodOptions.addAll(foodTypes);
    feederOptions.addAll(feederTypes);
    filteredCategories.assignAll(allCategories);
  }

  // final List<String> foodOptions = ['All', 'Seeds', 'Fruits', 'Insects'];
  // final List<String> foodImages = [
  //   AppImages.allCategory,
  //   AppImages.food1,
  //   AppImages.food2,
  //   AppImages.food3,
  // ];
  // final List<String> foodOptions = ['All', 'Seeds', 'Fruits', 'Insects'];

  // final List<String> feederOptions = ['All', 'Ground', 'Hanging'];
  // final List<String> feederImages = [
  //   AppImages.allCategory,
  //   AppImages.feeder1,
  //   AppImages.feeder2,
  // ];
  final RxString selectedFood = 'All'.obs;
  final RxString selectedFeeder = 'All'.obs;

  void selectCategory(CategoryItemModel cat) {
    selectedCategory.value = cat;
    List<BirdModel> birds = [
      BirdModel(
        title: 'American bush-tit',
        scientificName: 'Psaltriparus minimus',
        imageUrl: AppImages.commonbird6,
        category: 'Common Landbirds',
        foodType: 'Nyjer',
        feederType: 'Ground',
        rarityCategory: 'Common',
        grade: "A",
      ),
      BirdModel(
        title: 'American crow',
        scientificName: 'Corvus brachythryrhynchos',
        imageUrl: AppImages.commonbird7,
        category: 'Common Landbirds',
        foodType: 'All',
        feederType: 'All',
        rarityCategory: 'Common',
        grade: "A",
      ),
      BirdModel(
        title: 'American goldfinch',
        scientificName: 'Spinus tristis',
        imageUrl: AppImages.commonbird8,
        category: 'Common Landbirds',
        foodType: 'All',
        feederType: 'All',
        rarityCategory: 'Common',
        grade: "A",
      ),
      BirdModel(
        title: 'American robin',
        scientificName: 'Turdus migratorius',
        imageUrl: AppImages.commonbird9,
        category: 'Common Landbirds',
        foodType: 'All',
        feederType: 'All',
        rarityCategory: 'Common',
        grade: "A",
      ),
      BirdModel(
        title: 'American raptors',
        scientificName: 'Accipitridae spp.',
        imageUrl: AppImages.commonbird10,
        category: 'Common Landbirds',
        foodType: 'All',
        feederType: 'All',
        rarityCategory: 'Common',
        grade: "A",
      ),
      BirdModel(
        title: 'American colorful birds',
        scientificName: 'Various spp.',
        imageUrl: AppImages.commonbird1,
        category: 'Common Landbirds',
        foodType: 'All',
        feederType: 'All',
        rarityCategory: 'Common',
        grade: "A",
      ),
    ];
    allBirds.assignAll(birds);
    filteredBirds.assignAll(allBirds);
    // initialize birds for this category
    // filteredBirds.assignAll(
    //   allBirds.where((b) => b.category == cat.title).toList(),
    // );
  }

  void setFood(String f) {
    selectedFood.value = f;
    _applyBirdFilters();
  }

  void setFeeder(String f) {
    selectedFeeder.value = f;
    _applyBirdFilters();
  }

  void _applyBirdFilters() {
    var list = allBirds.where(
      (b) => b.category == selectedCategory.value?.title,
    );
    if (selectedFood.value != 'All') {
      list = list.where((b) => b.foodType == selectedFood.value);
    }
    if (selectedFeeder.value != 'All') {
      list = list.where((b) => b.feederType == selectedFeeder.value);
    }
    filteredBirds.assignAll(list.toList());
  }

  int get birdCount => filteredBirds.length;

  void onSearch(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(allCategories);
    } else {
      filteredCategories.assignAll(
        allCategories
            .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  String get title => _data.value.title;
  String get description => _data.value.description;
}
