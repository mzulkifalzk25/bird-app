import 'package:bird_discovery/models/bird_model.dart';
import 'package:bird_discovery/models/recent_activity_model.dart';
import 'package:bird_discovery/views/collection/models/collection_model.dart';
import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';
import 'package:get/get.dart';

import '../utils/app_images.dart';
import '../views/explore/controllers/explore_controller.dart';

// class RarityHighlightModel {
//   final String label;
//   final String description;
//   final String grade;
//   final bool isOverall;
//   RarityHighlightModel({
//     required this.label,
//     required this.description,
//     required this.grade,
//     this.isOverall = false,
//   });
// }

// class CollectionRecentActivityModel {
//   final String title;
//   final String dateAdded;
//   final String grade;
//   final String imageUrl;

//   CollectionRecentActivityModel({
//     required this.title,
//     required this.dateAdded,
//     required this.grade,
//     required this.imageUrl,
//   });
// }

class CollectionController extends GetxController {
  /// Current rarity filter label
  final selectedRarity = 'Rarity'.obs;
  final grade = 'All'.obs;

  /// Pagination
  final currentPage = 1.obs;
  final totalPages = 20;

  /// Grid vs List toggle
  final isGridView = true.obs;

  final myCollections = Rxn<CollectionModel>();
  final RxList<BirdModel> filteredCollection = <BirdModel>[].obs;
  // final RxList<CollectionRecentActivityModel> recentActivities =
  //     <CollectionRecentActivityModel>[].obs;

  @override
  void onInit() {
    fetchCollection();
    super.onInit();
  }

  final collectionScore = 'Impressive!'.obs;
  final rarityIndex = 'Rising'.obs;

  Future<void> fetchCollection() async {
    final body = CollectionModel(
      sRarityCount: 1,
      aRarityCount: 4,
      bRarityCount: 14,
      cRarityCount: 8,
      myCollections: [
        BirdModel(
          title: 'Hummingbirds',
          scientificName: 'Trochilidae spp.',
          imageUrl: AppImages.bird1,
          category: '…',
          foodType: '…',
          feederType: '…',
          rarityCategory: 'Rare',
          grade: 'S',
          dateAdded: '05-04-2025',
        ),
        BirdModel(
          title: 'Migratory Birds',
          scientificName: 'Various spp.',
          imageUrl: AppImages.bird2,
          category: '…',
          foodType: '…',
          feederType: '…',
          rarityCategory: 'Common',
          grade: 'A',
          dateAdded: '05-04-2025',
        ),
        BirdModel(
          title: 'Songbirds',
          scientificName: 'Passeriformes',
          imageUrl: AppImages.bird2,
          category: '…',
          foodType: '…',
          feederType: '…',
          rarityCategory: 'Common',
          grade: 'B',
          dateAdded: '05-04-2025',
        ),
      ],
      overallRarity: [
        OverallRarityModel(
          // regional abundance
          label: 'Regional Abundance',
          title: 'Extremely rare visitor (<5 sightings annually)',
          rarity: 'S',
        ),
        OverallRarityModel(
          // conservation status
          label: 'Conservation Status',
          title: 'Endangered or threatened(IUCN Red List species)',
          rarity: 'A',
        ),
        OverallRarityModel(
          // seasonal occurrence
          label: 'Seasonal Occurence',
          title: 'Out of normal seasonal range or migration pattern',
          rarity: 'B',
        ),
        OverallRarityModel(
          // population trend
          label: 'Population Trend',
          title: 'Declining population trend(>30% decline in 10 years)',
          rarity: 'C',
        ),
        OverallRarityModel(
          // overall significance
          label: 'Overall Significance',
          title: 'Exceptional find with high scientific/conservation value)',
          rarity: 'S/A',
        ),
      ],
    );
    myCollections.value = body;
    filteredCollection.assignAll(myCollections.value!.myCollections);
  }

  void setRarity(String rarity) {
    selectedRarity.value = rarity;
    grade.value = mapDropdownToRarity(rarity);
    print('grade is: ${grade.value}');
    filterCollection('');
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  String mapDropdownToRarity(String dropdown) {
    switch (dropdown) {
      case 'S-Rarity':
        return 'S';
      case 'A-Rarity':
        return 'A';
      case 'B-Rarity':
        return 'B';
      case 'C-Rarity':
        return 'C';
      default:
        return 'All';
    }
  }

  // void
  void filterCollection(String search) {
    // Start with all birds
    var list = myCollections.value?.myCollections ?? [];

    // Filter by grade (rarity) if not 'All'
    if (grade.value != 'All') {
      list = list.where((bird) => bird.grade == grade.value).toList();
    }

    // Filter by search query if not empty
    if (search.isNotEmpty) {
      list =
          list
              .where(
                (bird) =>
                    bird.title.toLowerCase().contains(search.toLowerCase()),
              )
              .toList();
    }

    // Assign the filtered list
    filteredCollection.assignAll(list.toList());
  }

  void toggleView(bool grid) => isGridView.value = grid;

  // final List<RarityHighlightModel> rarityHighlights = [
  //   RarityHighlightModel(
  //     label: 'Regional Abundance:',
  //     description: 'Extremely rare visitor (<5 sightings annually)',
  //     grade: 'S',
  //   ),
  //   RarityHighlightModel(
  //     label: 'Conservation Status:',
  //     description: 'Endangered or threatened (IUCN Red List species)',
  //     grade: 'S',
  //   ),
  //   RarityHighlightModel(
  //     label: 'Seasonal Occurrence:',
  //     description: 'Out of normal seasonal range or migration pattern',
  //     grade: 'S',
  //   ),
  // ];

  // final RarityHighlightModel overallSignificance = RarityHighlightModel(
  //   label: 'Overall Significance:',
  //   description: 'Exceptional find with high scientific/conservation value',
  //   grade: 'S/A',
  //   isOverall: true,
  // );
}
