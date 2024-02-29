import 'package:flutter/material.dart';

class CustomSnackbar {
  static Function(BuildContext, String, Color) show = (
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  };
}
