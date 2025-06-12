import 'dart:async';

import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/identifyBird/models/Identified_bird_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage {
  final String text;
  final bool isSender;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isSender, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();
}

class IdentifyBirdController extends GetxController {
  RxInt pageNo = 1.obs;
  RxBool isLoading = false.obs;
  RxString birdColor = ''.obs;
  RxString birdSize = ''.obs;
  RxString birdBehavior = ''.obs;
  RxString birdLocation = ''.obs;
  RxString birdDate = ''.obs;
  var birdList = <IdentifiedBirdModel>[].obs;
  var birdLisHotspot = <IdentifiedBirdModel>[].obs;
  var error = RxString(''); // Optional error state

  @override
  void onInit() {
    super.onInit();
    fetchBirdList();
  }

  void fetchBirdList() {
    isLoading(true); // Start loading
    error(''); // Clear any previous errors

    // Simulate API Call
    Future.delayed(Duration(seconds: 2), () {
      try {
        birdList.value = [
          IdentifiedBirdModel(
            id: 0,
            name: 'Scarlet Robin',
            scientificName: "Petroica boodang",
            imageUrl: AppImages.likelyBirds5, // Path to image asset
          ),
          IdentifiedBirdModel(
            id: 1,
            name: "Philippine Coucal",
            scientificName: "Petroica boodang",
            imageUrl: AppImages.likelyBirds6, // Path to another image asset
          ),
          IdentifiedBirdModel(
            id: 2,
            name: "Pacific Swallow",
            scientificName: "Petroica boodang",
            imageUrl: AppImages.likelyBirds7, // Path to another image asset
          ),
          IdentifiedBirdModel(
            id: 3,
            name: "Brown Shrike",
            scientificName: "Petroica boodang",
            imageUrl: AppImages.likelyBirds1, // Path to another image asset
          ),
          IdentifiedBirdModel(
            id: 4,
            name: "Striated Grassbird",
            scientificName: "Petroica boodang",
            imageUrl: AppImages.likelyBirds2, // Path to another image asset
          ),
        ];
      } catch (e) {
        error('Failed to load birds'); // Set error message
      } finally {
        isLoading(false); // Stop loading regardless of success/failure
      }
    });
  }

  void retryBirds() {
    fetchBirdList(); // This will automatically trigger loading state
  }

  //biding hotspot bird list
  // Example bird data
  List<IdentifiedBirdModel> birdListHotspot = [
    IdentifiedBirdModel(
      id: 0,
      name: 'Scarlet Robin',
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds5, // Path to image asset
    ),
    IdentifiedBirdModel(
      id: 1,
      name: "Philippine Coucal",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds6, // Path to another image asset
    ),
    IdentifiedBirdModel(
      id: 2,
      name: "Pacific Swallow",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds7, // Path to another image asset
    ),
    IdentifiedBirdModel(
      id: 3,
      name: "Brown Shrike",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds1, // Path to another image asset
    ),
    IdentifiedBirdModel(
      id: 4,
      name: "Striated Grassbird",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds2, // Path to another image asset
    ),
    IdentifiedBirdModel(
      id: 5,
      name: "Hammingbird",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds3, // Path to another image asset
    ),
    IdentifiedBirdModel(
      id: 6,
      name: "Scarlet Robin",
      scientificName: "Petroica boodang",
      imageUrl: AppImages.likelyBirds2, // Path to another image asset
    ),
  ];

  Rx<TextEditingController> locationController = TextEditingController().obs;

  RxDouble get indicatorBar {
    switch (pageNo.value) {
      case 1:
        return 0.1.obs;
      case 2:
        return 0.3.obs;
      case 3:
        return 0.5.obs;
      case 4:
        return 0.7.obs;
      case 5:
        return 0.9.obs;
      default:
        return 0.1.obs;
    }
  }

  List<String> questionList = [
    'What size was the bird?',
    'What were the main color?',
    'Was the Bird?',
    'When did you see the bird?',
    'Where did you see the bird?',
  ];

  List<Map<String, String>> birdSizeList = [
    {
      'image': AppImages.tinyBird,
      'size': 'Tiny',
      'measurement': '3-5 inches / 7.5-13 cm',
    },
    {
      'image': AppImages.smallBird,
      'size': 'Small',
      'measurement': '5-7 inches / 13-18 cm',
    },
    {
      'image': AppImages.mediumBird,
      'size': 'Medium',
      'measurement': '7-10 inches / 18-25 cm',
    },
    {
      'image': AppImages.largeBird,
      'size': 'Large',
      'measurement': '10-16 inches / 25-40 cm',
    },
    {
      'image': AppImages.veryLargeBird,
      'size': 'Very Large',
      'measurement': '16+ inches / 40+ cm',
    },
  ];

  List<Map<String, dynamic>> birdColorList = [
    {'colorName': 'Black', 'color': AppColors.blackColor},
    {'colorName': 'Gray', 'color': AppColors.birdGrey},
    {'colorName': 'Buff/Brown', 'color': AppColors.birdBrown},
    {'colorName': 'Red/Rufous', 'color': AppColors.birdRed},
    {'colorName': 'Yellow', 'color': AppColors.birdYellow},
    {'colorName': 'White', 'color': AppColors.whiteColor},
    {'colorName': 'Olive/Green', 'color': AppColors.birdOlive},
    {'colorName': 'Blue', 'color': AppColors.birdBlue},
    {'colorName': 'Orange', 'color': AppColors.birdOrange},
    {'colorName': 'Purple', 'color': AppColors.birdPurple},
  ];

  List<String> birdActivityList = [
    'Eating at a feeder',
    'Swimming or wading',
    'On the ground',
    'In trees or bushes',
    'On a fence or wire',
    'Soaring or flying',
  ];

  List<Map<String, String>> locationSearches = [
    {'city': 'Town Hall', 'location': 'Hong Kong'},
    {'city': 'Park Valley', 'location': 'Hong Kong'},
    {'city': 'Town Hall', 'location': 'Hong Kong'},
    {'city': 'Park Valley', 'location': 'Hong Kong'},
    {'city': 'Town Hall', 'location': 'Hong Kong'},
    {'city': 'Park Valley', 'location': 'Hong Kong'},
  ];

  Future<void> identifyBird() async {
    isLoading.value = true;
    print('''
{ 
'color': ${birdColor.value},
'size': ${birdSize.value},
'location': ${birdLocation.value},
'date': ${birdDate.value},
'behaviour': ${birdBehavior.value}
}
''');

    // bird list from response will be stored in ***birdList*** list
    Timer(Duration(seconds: 4), () {
      isLoading.value = false;
    });
  }

  // Chat related properties
  var chatMessages = <ChatMessage>[].obs;
  RxBool isChatLoading = false.obs;
  final TextEditingController chatController = TextEditingController();

  // Mock response for now - easy to replace with API later
  String get mockChatResponse =>
      "Yes, birds have the ability to see colors, in fact, many bird species have a wider range of color vision compared to humans, as they can see ultraviolet light as well. This allows them to perceive a broader spectrum of colors in their environment.";

  // Send message method
  Future<void> sendChatMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message immediately
    chatMessages.insert(0, ChatMessage(text: message, isSender: true));

    // Clear input
    chatController.clear();

    // Show loading state
    isChatLoading.value = true;

    try {
      // Call API method (currently mock)
      String response = await _getChatResponse(message);

      // Add bot response
      chatMessages.insert(0, ChatMessage(text: response, isSender: false));
    } catch (e) {
      // Handle error
      chatMessages.insert(
        0,
        ChatMessage(
          text: "Sorry, I couldn't process your message. Please try again.",
          isSender: false,
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }

  // This method will be easy to replace with actual API call
  Future<String> _getChatResponse(String userMessage) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // TODO: Replace this with actual API call
    // Example of what the API call might look like:
    /*
    final response = await http.post(
      Uri.parse('your-api-endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': userMessage,
        'context': 'bird_identification',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? 'Sorry, no response available.';
    } else {
      throw Exception('API call failed');
    }
    */

    return mockChatResponse;
  }

  @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}
