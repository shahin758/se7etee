import 'package:flutter/material.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/custome_text_form_field.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_cubit.dart';

class DoctorPhoneNumbers extends StatelessWidget {
  const DoctorPhoneNumbers({
    super.key,
    required this.cubit,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 1',
                style: TextStyles.body16.copyWith(color: AppColors.darkcolor),
              ),
            ],
          ),
        ),
        CustomeTextFormField(
          controller: cubit.phone1Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',

          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: TextStyles.body16.copyWith(color: AppColors.darkcolor),
              ),
            ],
          ),
        ),
        CustomeTextFormField(
          controller: cubit.phone2Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',
        ),
      ],
    );
  }
}
