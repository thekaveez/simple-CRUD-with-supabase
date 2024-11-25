

import 'package:flutter/material.dart';

class AppColors{

  static const Color kBgColor = Color(0xFF202326);
  static const Color kPrimaryColor = Color(0xFF2E3BFF);

  static const int gradientStart = 0xFF202326;
  static const int gradientEnd = 0xFF202326;

  LinearGradient kLinearGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(gradientStart),
      Color(gradientEnd),
    ],
  );
}