import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/constants/app_images.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/features/intro/welcome/widgets/gesture_detector_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          PositionedDirectional(
            top: 100,
            start: 25,
            end: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اهلا بيك',
                  style: TextStyles.headline30.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                  ),
                ),
                const Gap(15),
                Text(
                  'سجل واحجز عند دكتورك وانت فالبيت',
                  style: TextStyles.body16,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 70,
            start: 25,
            end: 25,
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'سجل دلوقتي كــ',
                    style: TextStyles.text20.copyWith(
                      color: AppColors.whitecolor,
                    ),
                  ),
                  Gap(40),
                  GestureDetectorWidget(
                    title: 'دكتور',
                    onTap: () {
                      pushTo(context, Routes.login, extra: UserTypeEnum.doctor);
                    },
                  ),
                  Gap(15),
                  GestureDetectorWidget(
                    title: 'مريض',
                    onTap: () {
                      pushTo(
                        context,
                        Routes.login,
                        extra: UserTypeEnum.patient,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
