import 'package:bird_discovery/models/bird_model.dart';
import 'package:bird_discovery/models/recent_activity_model.dart';
import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';

class CollectionModel {
  List<BirdModel> myCollections;
  // List<RecentActivityModel> recentCollection;
  List<OverallRarityModel> overallRarity;
  int sRarityCount;
  int aRarityCount;
  int bRarityCount;
  int cRarityCount;

  CollectionModel({
    required this.sRarityCount,
    required this.aRarityCount,
    required this.bRarityCount,
    required this.cRarityCount,
    required this.myCollections,
    // required this.recentCollection,
    required this.overallRarity,
  });
}
