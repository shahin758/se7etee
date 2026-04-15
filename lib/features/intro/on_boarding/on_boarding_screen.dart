import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/services/local/shared_pref.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/custom_svg_picture.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/core/widgets/my_body_view.dart';
import 'package:se7etee/features/intro/on_boarding/on_boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (currentPage != onboardingList.length - 1)
            TextButton(
              onPressed: () {
                SharedPref.setOnboardingShown();
                pushReplacement(context, Routes.welcome);
              },
              child: Text(
                'تخطي',
                style: TextStyles.body16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
      body: MyBodyView(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: 1),
                        CustomSvgPicture(
                          path: onboardingList[index].image,
                          width: 250,
                        ),
                        Spacer(flex: 1),
                        Text(
                          onboardingList[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyles.text20.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Gap(10),
                        Text(
                          onboardingList[index].description,
                          textAlign: TextAlign.center,
                          style: TextStyles.subtitle18,
                        ),
                        Spacer(flex: 2),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: onboardingList.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotColor: AppColors.greycolor,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                    ),
                    if (currentPage == onboardingList.length - 1)
                      MainButton(
                        minWidth: 90,
                        minHeight: 45,
                        onPressed: () {
                          SharedPref.setOnboardingShown();
                          pushReplacement(context, Routes.welcome);
                        },
                        text: 'هيا بنا',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
