import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: const Color(0xFFFFF1D4), // Gold
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF29384D), // Dark Blue
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFE2F4F6), // Light Blue
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xFFFFF1D4), // Gold
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 2, color: Color(0xFFFFF1D4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 2, color: Color(0xFFFFF1D4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xFFEE403D), // Red
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 2, color: Color(0xFFEE403D)),
        ),
      ),
    );
  }
}
