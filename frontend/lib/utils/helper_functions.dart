//All helper functions in one file
import 'package:bird_discovery/views/home/bird_analytics/widgets/rarity_card_overview.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

//Helper function to determine gradicent color:
Gradient getGradientColor(String grade) {
  switch (grade) {
    case 'A':
      return AppColors.aGradeGradient;
    case 'B':
      return AppColors.bGradeGradient;
    case 'C':
      return AppColors.cGradeGradient;
    default:
      return AppColors.sGradeGradient;
  }
}

RarityGrade getRarityType(String grade) {
  switch (grade) {
    case 'A':
      return RarityGrade.A;
    case 'B':
      return RarityGrade.B;
    case 'C':
      return RarityGrade.C;
    case 'D':
      return RarityGrade.D;
    case 'S':
      return RarityGrade.S;
    default:
      return RarityGrade.S;
  }
}
