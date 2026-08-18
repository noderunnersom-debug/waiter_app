import 'dart:ui';

class AppColors {
  static const Color mainColor = Color(0xFFFAFAFA);

  static const Color buttonBlue = Color(0xFF2263EB);
  static const Color buttonGrey = Color(0xFF878B94);

  static const Color forBorderGrey = Color(0xFF878B94);

  static const Color backgroundLight = Color(0xFFFEFEFE);
  static const Color backgroundMidl = Color(0xFFF0F2F4);
  static const Color backgroundHard = Color(0xFFECECEC);

  static const Color textDark = Color(0xFF1C1C22);
  static const Color textMidl = Color(0xFF96A1AF);
  static const Color textL1ight = Color(0xFFF8FAFC);

  static const Color forMoney = Color(0xFF2263EB);

  static const Color screenSplitting = Color(0xFFE7E8E9);
  static const  placeholderColor = Color(0x00000000);

  static const Color tableStatusFreeText = Color(0xFF10B981);
  static  Color get tableStatusFreeBackground => tableStatusFreeText.withOpacity(0.15);
  static const Color tableStatusBusyText = Color(0xFFF43F5E);
  static  Color get tableStatusBusyBackground => tableStatusBusyText.withOpacity(0.15);
  static const Color tableStatusBookedText = Color(0xFFB45400);
  static  Color get tableStatusBookedBackground => tableStatusBookedText.withOpacity(0.15);
}
