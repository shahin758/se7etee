import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7etee/core/constants/app_images.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/custome_text_form_field.dart';
import 'package:se7etee/core/widgets/dialogs.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/features/auth/data/model/specialization.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7etee/features/doctor/widgets/doctor_phone_numbers.dart';

class UpdateDoctorProfileScreen extends StatefulWidget {
  const UpdateDoctorProfileScreen({super.key});

  @override
  State<UpdateDoctorProfileScreen> createState() =>
      _UpdateDoctorProfileScreenState();
}

class _UpdateDoctorProfileScreenState extends State<UpdateDoctorProfileScreen> {
  String? _imagePath;
  File? imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        context.read<AuthCubit>().imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('المعرض'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('الكاميرا'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            if (state.userType == UserTypeEnum.patient) {
              pop(context);
              log('success');
            } else {}
          } else if (state is AuthFailureState) {
            pop(context);
            showMyDialog(context, state.errorMessage);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('إكمال عملية التسجيل')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              // backgroundColor: AppColors.lightBg,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.whitecolor,
                                backgroundImage: (_imagePath != null)
                                    ? FileImage(File(_imagePath!))
                                    : AssetImage(AppImages.docPlaceholder),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showPicker();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                  // color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                          child: Row(
                            children: [
                              Text(
                                'التخصص',
                                style: TextStyles.body16.copyWith(
                                  color: AppColors.darkcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // التخصص---------------
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String?>(
                            isExpanded: true,
                            iconEnabledColor: AppColors.primaryColor,
                            hint: Text(
                              'اختر التخصص',
                              style: TextStyles.body16.copyWith(
                                color: AppColors.greycolor,
                              ),
                            ),
                            icon: const Icon(Icons.expand_circle_down_outlined),
                            value: cubit.specialization,
                            onChanged: (String? newValue) {
                              setState(() {
                                cubit.specialization = newValue;
                              });
                            },
                            items: [
                              for (var specialization in specializations)
                                DropdownMenuItem(
                                  value: specialization,
                                  child: Text(specialization),
                                ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'نبذة تعريفية',
                                style: TextStyles.body16.copyWith(
                                  color: AppColors.darkcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomeTextFormField(
                          controller: cubit.bioController,
                          maxLines: 4,
                          hintText:
                              'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل النبذة التعريفية';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'عنوان العيادة',
                                style: TextStyles.body16.copyWith(
                                  color: AppColors.darkcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomeTextFormField(
                          controller: cubit.addressController,
                          hintText: '5 شارع مصدق - الدقي - الجيزة',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل عنوان العيادة';
                            } else {
                              return null;
                            }
                          },
                        ),
                        _workHours(cubit),

                        DoctorPhoneNumbers(cubit: cubit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(top: 25.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: MainButton(
                onPressed: () async {
                  if (cubit.formKey.currentState!.validate()) {
                    if (imageFile != null) {
                      cubit.updateDoctorProfile();
                    } else {
                      showMyDialog(
                        context,
                        'من فضلك قم باختيار صورة الصفحة الشخصية',
                      );
                    }
                  }
                },
                text: "التسجيل",
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'ساعات العمل من',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'الي',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomeTextFormField(
                readOnly: true,
                controller: cubit.openHourController,
                onTap: () async {
                  await showStartTimePicker(cubit);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showStartTimePicker(cubit);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
            const SizedBox(width: 10),

            // ---------- End Time ----------------
            Expanded(
              child: CustomeTextFormField(
                readOnly: true,
                controller: cubit.closeHourController,
                onTap: () async {
                  await showEndTimePicker(cubit);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showEndTimePicker(cubit);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthCubit cubit) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
       cubit.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthCubit cubit) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
     cubit.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
