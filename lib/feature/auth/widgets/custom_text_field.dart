import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

class CustomTextFiedl extends StatelessWidget {
  const CustomTextFiedl({
    super.key,
    required this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    required this.keyboardType,
    this.prefixText,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintStyle: const TextStyle(color: COLORS.greyDark),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: COLORS.greenDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: COLORS.greenDark, width: 2),
        ),
      ),
    );
  }
}
