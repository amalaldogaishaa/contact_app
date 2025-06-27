import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFF1D4), // Gold
        foregroundColor: const Color(0xFF29384D), // Dark Blue text
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        //  overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal, // Regular
        ),
      ),
      onPressed: onPressed,
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }
}
