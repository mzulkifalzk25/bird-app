import 'package:bird_discovery/models/home_model.dart';
import 'package:bird_discovery/models/recent_activity_model.dart';
import 'package:bird_discovery/views/explore/models/category_item_model.dart';
import 'package:bird_discovery/views/home/widgets/neaby_bird_activity.dart';
import 'package:get/get.dart';

import '../utils/app_images.dart';

class HomeController extends GetxController {
  //for birding hotspot screen
  final RxBool showLocationDialog = true.obs;

  // void onInit() {

  //   super.onInit();
  // }

  // final sRarity = 1.obs;
  // final aRarity = 4.obs;
  // final bRarity = 14.obs;
  // final cRarity = 8.obs;
  final collectionScore = 'Impressive!'.obs;
  final rarityIndex = 'Rising'.obs;

  // // Bragging Rights
  // final topFindPercent = '5%'.obs;
  // final collectionRank = '5%'.obs;
  // final locationCount = '12'.obs;
  // final streakStatus = '14'.obs;
  final Rx<HomeModel?> homeItems = Rx<HomeModel?>(null);
  final recentActivity = <RecentActivityModel>[].obs;
  // Alert
  final alertTitle = 'S-Rarity Bird Sighting Alert!'.obs;
  final alertMessage = 'Peregrine Falcon spotted 2 miles away'.obs;

  // final List<CategoryItemModel> nearbyBirds = [
  //   CategoryItemModel(title: 'Hummingbirds', imageUrl: AppImages.bird4),
  //   CategoryItemModel(title: 'Songbirds', imageUrl: AppImages.bird5),
  //   CategoryItemModel(title: 'Migratory Birds', imageUrl: AppImages.bird1),
  //   CategoryItemModel(title: 'Waterfowl', imageUrl: AppImages.bird2),
  //   CategoryItemModel(title: 'Birds of Prey', imageUrl: AppImages.bird3),
  // ];
  void searchItem(String search) {
    var list = homeItems.value?.recentActivities ?? [];
    if (search.isNotEmpty) {
      list =
          list
              .where(
                (bird) =>
                    bird.title.toLowerCase().contains(search.toLowerCase()),
              )
              .toList();
    }
    recentActivity.assignAll(list);
  }

  /// Recent Activity
  // final List<RecentActivityModel> recentActivities = ;

  Future<void> fetchDetails(
    // paramenters to fetch data goes here
  ) async {
    final body = HomeModel(
      rareFindPercent: '5%',
      collectionRank: '5%',
      locationExploredCount: '12',
      activeStreak: '14',
      nearbyBirds: [
        CategoryItemModel(title: 'Hummingbirds', imageUrl: AppImages.bird4),
        CategoryItemModel(title: 'Hummingbirds', imageUrl: AppImages.bird4),
        CategoryItemModel(title: 'Hummingbirds', imageUrl: AppImages.bird4),
        CategoryItemModel(title: 'Hummingbirds', imageUrl: AppImages.bird4),
      ],
      recentActivities: [
        RecentActivityModel(
          title: 'Scarlet Robin',
          dateAdded: 'Jan 2025',
          grade: 'S',
          imageUrl: AppImages.bird1,
        ),
        RecentActivityModel(
          title: 'Hummingbirds',
          dateAdded: 'Mar 2025',
          grade: 'B',
          imageUrl: AppImages.bird2,
        ),
        RecentActivityModel(
          title: 'Songbirds',
          dateAdded: 'Apr 2025',
          grade: 'A',
          imageUrl: AppImages.bird3,
        ),
        RecentActivityModel(
          title: 'Migratory Birds',
          dateAdded: 'May 2025',
          grade: 'C',
          imageUrl: AppImages.bird5,
        ),
        RecentActivityModel(
          title: 'Waterfowl',
          dateAdded: 'Jun 2025',
          grade: 'S',
          imageUrl: AppImages.bird4,
        ),
        RecentActivityModel(
          title: 'Birds of Prey',
          dateAdded: 'Jul 2025',
          grade: 'A',
          imageUrl: AppImages.bird2,
        ),
        RecentActivityModel(
          title: 'Scarlet Robin',
          dateAdded: 'Aug 2025',
          grade: 'B',
          imageUrl: AppImages.bird3,
        ),
      ],
    );
    homeItems.value = body;
    recentActivity.assignAll(homeItems.value!.recentActivities);
  }
}
