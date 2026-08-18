import 'package:flutter/material.dart';
import 'package:waiter_app/core/style/app_colors.dart';

class AppInputDecoration {
  static InputDecoration textField({
    String? hintText,
    Color? fillColor,
    Color? focusColor,
  }) => InputDecoration(
    filled: true,
    fillColor: fillColor ?? AppColors.backgroundLight,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 0, color: AppColors.forBorderGrey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 2, color: focusColor ?? AppColors.buttonBlue),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    hintText: hintText,
  );
}
