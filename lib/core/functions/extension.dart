import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Prefrences on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

bool isArabic(BuildContext context) {
  return context.locale.languageCode == 'ar';
}
