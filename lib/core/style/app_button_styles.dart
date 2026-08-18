import 'package:flutter/material.dart';
import 'package:waiter_app/core/style/app_colors.dart';

class AppButtonStyles {
  static ButtonStyle orderButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonBlue,
    foregroundColor: AppColors.buttonBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  );
  static ButtonStyle settlingTheBill = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.buttonGrey,
    foregroundColor: AppColors.buttonGrey,
  );
  static ButtonStyle tablesCardButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.zero,
  );
  static ButtonStyle menuStatusFree = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.tableStatusFreeBackground,
    foregroundColor: AppColors.buttonGrey,
  );
  static ButtonStyle menuStatusBusy = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.tableStatusBusyBackground,
    foregroundColor: AppColors.buttonGrey,
  );
  static ButtonStyle menuStatusBooked = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.tableStatusBookedBackground,
    foregroundColor: AppColors.buttonGrey,
  );
  static ButtonStyle menuStatus = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.backgroundMidl,
    foregroundColor: AppColors.buttonGrey,
  );
}
