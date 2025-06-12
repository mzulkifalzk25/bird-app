import 'dart:async';

import 'package:bird_discovery/utils/app_images.dart';
import 'package:get/get.dart';

class LearnCategories {
  String name;
  String icon;
  LearnCategories({required this.name, required this.icon});
}

class ArticleModel {
  String userImage;
  String articleImage;
  String userName;
  String date;
  String title;
  String subtitle;
  List<String> tags;
  ArticleModel({
    required this.userImage,
    required this.articleImage,
    required this.userName,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.tags,
  });
}

class BirdReadingController extends GetxController {
  final selectedCategory = 0.obs;
  final isLoading = false.obs;
  RxList<ArticleModel> favorites = <ArticleModel>[].obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  final List<LearnCategories> categories = [
    LearnCategories(name: 'All', icon: AppImages.categoryAll),
    LearnCategories(name: 'Training', icon: AppImages.categoryTraining),
    LearnCategories(name: 'Species', icon: AppImages.categorySpecies),
    LearnCategories(name: 'Health', icon: AppImages.categorySpecies),
    LearnCategories(
      name: 'Exercie & Activites',
      icon: AppImages.categorySpecies,
    ),
    LearnCategories(name: 'Behavior', icon: AppImages.categorySpecies),
    LearnCategories(
      name: 'Breeds & Reproduction',
      icon: AppImages.categorySpecies,
    ),
  ];

  final articles = [
    ArticleModel(
      userImage: AppImages.user1,
      articleImage: AppImages.bird1,
      userName: 'Jenny Wilson',
      date: '3 Mar',
      title: '5 Tips for your bird health care:\nUltimate Guide 2025',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Diam ornare scelerisque ultrices adipiscing massa aliquet.',
      tags: ['PetsCare', 'Learning'],
    ),
    ArticleModel(
      userImage: AppImages.user2,
      articleImage: AppImages.bird2,
      userName: 'Robert Fox',
      date: '3 Mar',
      title: '5 Tips for your bird health care:\nUltimate Guide 2025',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Diam ornare scelerisque ultrices adipiscing massa aliquet.',
      tags: ['PetsCare', 'Learning'],
    ),
    ArticleModel(
      userImage: AppImages.user3,
      articleImage: AppImages.bird3,
      userName: 'Kristin Watson',
      date: '3 Mar',
      title: '5 Tips for your bird health care:\nUltimate Guide 2025',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Diam ornare scelerisque ultrices adipiscing massa aliquet.',
      tags: ['PetsCare', 'Learning'],
    ),
    ArticleModel(
      userImage: AppImages.user1,
      articleImage: AppImages.bird1,
      userName: 'Jenny',
      date: '3 Mar',
      title: '5 Tips for your bird health care:\nUltimate Guide 2025',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Diam ornare scelerisque ultrices adipiscing massa aliquet.',
      tags: ['PetsCare', 'Learning'],
    ),
    ArticleModel(
      userImage: AppImages.user2,
      articleImage: AppImages.bird3,
      userName: 'Wilson',
      date: '3 Mar',
      title: '5 Tips for your bird health care:\nUltimate Guide 2025',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Diam ornare scelerisque ultrices adipiscing massa aliquet.',
      tags: ['PetsCare', 'Learning'],
    ),
  ];
  void fetchArticles() {
    isLoading.value = true;
    Timer(Duration(seconds: 3), () {
      isLoading.value = false;
    });
  }
}
