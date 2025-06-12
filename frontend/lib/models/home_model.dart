import 'package:bird_discovery/models/recent_activity_model.dart';
import 'package:bird_discovery/views/explore/models/category_item_model.dart';

class HomeModel {
  String rareFindPercent;
  String collectionRank;
  String locationExploredCount;
  String activeStreak;
  List<CategoryItemModel> nearbyBirds;
  List<RecentActivityModel> recentActivities;

  HomeModel({
    required this.rareFindPercent,
    required this.collectionRank,
    required this.locationExploredCount,
    required this.activeStreak,
    required this.nearbyBirds,
    required this.recentActivities,
  });
}
