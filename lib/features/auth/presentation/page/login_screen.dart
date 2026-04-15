import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/constants/app_images.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/functions/validations.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/custome_text_form_field.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/core/widgets/password_text_form_field.dart';
import 'package:se7etee/features/auth/widgets/social_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor, 
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            // key: bloc.formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, height: 200),
                  const SizedBox(height: 20),
                  Text(
                    'سجل دخول الان كـ "${handleUserType()}"',
                    style: TextStyles.title24.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomeTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                    // controller: bloc.emailController,
                    hintText: 'omar@example.com',
                    prefixIcon: Icon(Icons.email_rounded,color: AppColors.primaryColor,),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!isValidEmail(value)) {
                        return 'من فضلك ادخل الايميل صحيحا';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
                  PasswordTextFormField(
                    hintText: '********',
                    prefixIcon: const Icon(Icons.lock_rounded,color: AppColors.primaryColor,),
                    // controller: bloc.passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsetsDirectional.only(
                      top: 10,
                      start: 10,
                    ),
                    child: Text(
                      'نسيت كلمة السر ؟',
                      style: TextStyles.caption212,
                    ),
                  ),
                  const Gap(18),
                  MainButton(onPressed: () async {}, text: "تسجيل الدخول"),
                  const Gap(28),
                  SocialLogin(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'ليس لدي حساب ؟',
                            style: TextStyles.body16.copyWith(
                              color: AppColors.darkcolor,
                            ),
                            children: [
                              TextSpan(
                                text: ' سجل الان',
                                style: TextStyles.body16.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    pushReplacement(
                                      context,
                                      Routes.register,
                                      extra: widget.userType,
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
