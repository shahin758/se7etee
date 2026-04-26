
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/functions/validations.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/custome_text_form_field.dart';
import 'package:se7etee/core/widgets/dialogs.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/core/widgets/password_text_form_field.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          if (widget.userType == UserTypeEnum.patient) {
            pushReplacement(context, Routes.patientMainApp);
          } else {
            pushReplacement(context, Routes.doctorUpdateProfile);
          }
        } else if (state is AuthFailureState) {
          pop(context);
          showMyDialog(context, state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.accentColor,
          leading: const BackButton(color: AppColors.primaryColor),
        ),
        body: _registerForm(context),
      ),
    );
  }

  Center _registerForm(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 200),
                const SizedBox(height: 20),
                Text(
                  'سجل حساب جديد كـ "${handleUserType()}"',
                  style: TextStyles.title24,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: cubit.nameController,
                  decoration: const InputDecoration(
                    hintText: 'اسم المستخدم',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل الاسم';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 25.0),
                CustomeTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  textAlign: TextAlign.end,
                  hintText: 'ادخل الايميل',
                  prefixIcon: Icon(Icons.email_rounded),
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
                  controller: cubit.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                    return null;
                  },
                ),

                const Gap(20),
                MainButton(
                  onPressed: () async {
                    if (cubit.formKey.currentState!.validate()) {
                      await cubit.register(widget.userType);
                    }
                  },
                  text: "تسجيل حساب جديد",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لدي حساب ؟',
                        style: TextStyles.body16.copyWith(
                          color: AppColors.darkcolor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          pushReplacement(
                            context,
                            Routes.login,
                            extra: widget.userType,
                          );
                        },
                        child: Text(
                          'سجل دخول',
                          style: TextStyles.body16.copyWith(
                            color: AppColors.primaryColor,
                          ),
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
    );
  }
}
