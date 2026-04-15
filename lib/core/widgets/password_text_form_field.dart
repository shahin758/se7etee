import 'package:flutter/material.dart';
import 'package:se7etee/core/styles/colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onTap,
        this.prefixIcon,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
    final Widget? prefixIcon;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText: true,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          color: AppColors.primaryColor,
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.remove_red_eye),
        ),
        prefixIcon: widget.prefixIcon,
      ),
      validator: widget.validator,
    );
  }
}
