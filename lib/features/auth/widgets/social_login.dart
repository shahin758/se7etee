import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.accentColor, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'او',
                style: TextStyles.body16.copyWith(color: AppColors.darkcolor),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.accentColor, thickness: 1),
            ),
          ],
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                // signInWithGoogle().then((value) {
                //   log(value.user?.email.toString() ?? '');
                // });
              },
              child: const Text('Google'),
            ),
          ],
        ),
      ],
    );
  }
}