import 'package:flutter/material.dart';
import 'package:waiter_app/core/style/app_colors.dart';

class AppTextStyle {
  static TextStyle headlineLarge({Color? color}) =>
      TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: color);

  static TextStyle headlineMedium({Color? color}) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color);

  static TextStyle headlineSmoll({Color? color}) =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color);

  static TextStyle bodyLarge({Color? color}) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodyMedium({Color? color}) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodyMediumBold({Color? color}) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color);

  static TextStyle buttonLarge({Color? color}) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color);

  static TextStyle buttonSmall({Color? color}) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color);

  static TextStyle priceLarge({Color? color}) =>
      TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: color);

  static TextStyle appBarSmall({Color? color}) => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle appBarLarge({Color? color}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w900,
    color: AppColors.textDark,
  );

  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) => TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}
