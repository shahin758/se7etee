import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChanged,
    this.textInputAction,
    this.controller,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.suffixIcon,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final int? maxLines;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        if (keyboardType == TextInputType.phone)
          LengthLimitingTextInputFormatter(11),
      ],
      maxLines: maxLines,
      focusNode: focusNode,
      keyboardType: keyboardType,
      readOnly: readOnly,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText, prefixIcon: prefixIcon, suffixIcon: suffixIcon),
      validator: validator,
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap: onTap,
    );
  }
}
