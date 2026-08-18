import 'package:flutter/material.dart';
import 'package:waiter_app/core/style/app_colors.dart';

class AppBorders {
  static const BorderSide none = BorderSide(
    width: 0,
    color: Colors.transparent,
  );
  static BorderSide width1({Color? color}) =>
      BorderSide(color: color ?? AppColors.forBorderGrey, width: 1);
  static BorderSide width2({Color? color}) =>
      BorderSide(color: color ?? AppColors.forBorderGrey, width: 2);
  static BorderSide width4({Color? color}) =>
      BorderSide(color: color ?? AppColors.forBorderGrey, width: 3);
}
