import 'package:contact_app/colors.dart';
import 'package:flutter/material.dart';

class CustomUnderlineTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final BorderSide? enabledBorderSide;

  const CustomUnderlineTextField({
    Key? key,
    required this.hintText,
    this.hintStyle,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.enabledBorderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasBorder = enabledBorderSide != null;
    final BorderSide defaultBorderSide = BorderSide(
      color: AppColors.buttonsColors,
    );

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: (hasBorder ? enabledBorderSide!.color : AppColors.buttonsColors),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            hintStyle ??
            TextStyle(
              color: (hasBorder
                  ? enabledBorderSide!.color
                  : AppColors.buttonsColors),
            ),
        enabledBorder: hasBorder
            ? UnderlineInputBorder(borderSide: enabledBorderSide!)
            : InputBorder.none,
        focusedBorder: hasBorder
            ? UnderlineInputBorder(borderSide: enabledBorderSide!)
            : InputBorder.none,
      ),
    );
  }
}
