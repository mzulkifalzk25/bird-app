// lib/controllers/bird_analytics_controller.dart

import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';
import 'package:get/get.dart';
import '../../../../utils/app_images.dart';

class BirdAnalyticsController extends GetxController {
  /// PageView images
  final RxList<String> pageImages =
      <String>[AppImages.bird1, AppImages.bird2, AppImages.bird3].obs;

  /// Albums strip images
  final RxList<String> albumImages =
      <String>[
        AppImages.bird1,
        AppImages.bird2,
        AppImages.bird3,
        AppImages.bird1,
        AppImages.bird2,
        AppImages.bird3,
      ].obs;

  /// The details block
  final birdDetails = Rx<BirdAnalyticsModel>(
    BirdAnalyticsModel(
      name: '',
      scientificName: '',
      confidenceLevel: '',
      time: '',
      location: '',
      tags: [],
      images: [],
      quickFacts: [],
      rarityType: '',
      rarityDesc: '',
      description: '',
      overallRarityList: [],
      sounds: [],
      foodList: [],
      feederList: [],
      distributionArea: '',
      identificationMarksList: [],
      physicalCharacteristics: [],
      behavioralTaits: BehavioralTaitsModel(
        traits: [],
        seasonalAppearance: '',
        diet: '',
      ),
      nestingReproduction: NestingReproductionModel(
        breedingSeason: '',
        nest: '',
        eggs: '',
        fledging: '',
      ),
      conservationReminders: [],
      scientificClassification: [],
      similarSpeciesList: [],
      facts: '',
    ),
  );

  @override
  void onInit() {
    final body = BirdAnalyticsModel(
      name: '',
      scientificName: 'Lesser Voiletear',
      confidenceLevel: '92%',
      time: 'Today, 2:24 pm',
      location: 'Backyard',
      tags: ['Safe for plants', 'No-toxic'],
      images: [
        AppImages.bird5,
        AppImages.bird2,
        AppImages.bird3,
        AppImages.bird1,
        AppImages.bird2,
        AppImages.bird3,
      ],
      quickFacts: [
        'Least Concern',
        'Woodland Edges',
        'Year-around',
        'Common in area',
      ],
      rarityType: 'B',
      rarityDesc:
          "A legendary collector's item with exceptional investment potential & cultural significance.",
      description:
          'The Eastern Bluebird is a small thrush with a big, rounded head, large eye, plump body, and short, straight bill. The wings are long, but the tail and legs are fairly short. Males are vivid, deep blue above and rusty or brick-red on the throat and breast with a white belly. Females are grayish above with bluish wings and tail, and a subdued orange- brown breast.',
      overallRarityList: [
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
      sounds: ['assets/sounds/song1.wav'],
      foodList: [
        FoodModel(image: AppImages.food1, name: 'Black oil sunflower seeds'),
        FoodModel(image: AppImages.food2, name: 'Cracked Corn'),
        FoodModel(image: AppImages.food1, name: 'Hulled Sunflower Seeds'),
        FoodModel(image: AppImages.food1, name: 'Hulled Sunflower Seeds'),
      ],
      feederList: [
        FeederModel(image: AppImages.feeder1, name: 'Ground'),
        FeederModel(image: AppImages.feeder1, name: 'Platform'),
        FeederModel(image: AppImages.feeder1, name: 'Ground'),
      ],
      distributionArea:
          'The lesser violetear is roughly medium -sized by hummingbird standards. It averages around 9.7 to 12 cm (3.8 to 4.7 in) in total length. It’s bill is black and mostly straight with only a slight downward ',
      identificationMarksList: [
        'Bright red plumage (male)',
        'Distinctive crest',
        'Black face mask',
        'Heavy, cone-shaped bill',
        'Heavy, cone-shaped bill',
        'Heavy, cone-shaped bill',
      ],
      physicalCharacteristics: [
        PhysicalCharacteristicsModel(title: 'length', value: '21-23 cm'),
        PhysicalCharacteristicsModel(title: 'wingspan', value: '25-31 cm'),
        PhysicalCharacteristicsModel(title: 'weight', value: '42-48 g'),
      ],
      behavioralTaits: BehavioralTaitsModel(
        traits: [
          'Often perches or wires, posts, and low branches',
          'Hovers before dropping to the ground catch insects',
          'Nests in tree cavities or nest boxes',
        ],
        seasonalAppearance:
            'Males maintain their bright coloration year-round, though',
        diet: 'Seeds, fruits, insects',
      ),
      nestingReproduction: NestingReproductionModel(
        breedingSeason: 'April to August',
        nest: 'Cup-shaped in shrubs or trees',
        eggs: '2-5, incubation 11-13 days',
        fledging: 'Young leave nest after 7-13 days',
      ),
      conservationReminders: [
        ConservationRemindersModel(
          title: 'Sensitive Area:',
          description:
              'Blue Jay nests likely present (April–June). Please avoid leaving the main trail and refrain from using recorded bird calls.',
        ),
        ConservationRemindersModel(
          title: 'Ethics Reminder:',
          description:
              'Blue Jays may abandon nests if disturbed. Observe quietly and do not approach or photograph active nests closely',
        ),
      ],
      scientificClassification: [
        ScientificClassificationModel(
          title: 'Genus',
          description: 'Regulus-Kinglets, Crest, Kinglets and Crests, Kinglet',
        ),
        ScientificClassificationModel(
          title: 'Family',
          description: 'Regulidae- Goldcrests and kinglets',
        ),
        ScientificClassificationModel(
          title: 'Order',
          description:
              'Passeriflormes- Perching birds, Songsters, Songbirds, passe',
        ),
      ],
      similarSpeciesList: [
        SimilarSpeciesModel(
          id: 10,
          name: 'Mountain Bluebird',
          scientificName: 'Sialia currucoides',
          description: 'Lighter, sky-blue coloration with no rusty breast',
          image: AppImages.bird2,
        ),
        SimilarSpeciesModel(
          id: 10,
          name: 'Indigo Bunting',
          scientificName: 'Passerina cyanea',
          description: 'Lighter, sky-blue coloration with no rusty breast',
          image: AppImages.bird3,
        ),
      ],
      facts:
          'Dogs often use gentle mouthing as a sign of affection, but setting boundaries helps ensure play remains comfortable for both of you. 🐕💙',
    );
    birdDetails.value = body;
    super.onInit();
  }

  Future<bool> sendSuggestions(String text) async {
    final result = true;
    return result;
  }

  Future<bool> sendErrorInContent(String text) async {
    final result = true;
    return result;
  }

  Future<void> fetchBirdData() async {}
  Future<void> fetchBirdDataByVoice() async {}
  Future<void> fetchBirdDataByImage() async {}
}
