
import 'package:flutter/material.dart';
import 'package:se7etee/core/constants/app_images.dart';

import 'package:se7etee/core/widgets/custom_svg_picture.dart';

class CustomeBackButton extends StatelessWidget {
  const CustomeBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CustomSvgPicture(path: AppImages.back),
          ),
        ),
      ],
    );
  }
}
