import 'package:flutter/material.dart';
import 'package:se7etee/core/styles/colors.dart';

abstract class TextStyles {
  static const TextStyle headline30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle title24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle text20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle caption114 = TextStyle(fontSize: 14);
  static const TextStyle caption212 = TextStyle(
    fontSize: 12,
    color: AppColors.textcolor,
    fontWeight: FontWeight.bold,
  );
}
