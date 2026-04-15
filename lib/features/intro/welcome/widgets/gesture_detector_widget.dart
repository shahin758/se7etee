import 'package:flutter/material.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';

class GestureDetectorWidget extends StatelessWidget {
  const GestureDetectorWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.accentColor.withValues(alpha: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyles.text20.copyWith(color: AppColors.darkcolor),
          ),
        ),
      ),
    );
  }
}