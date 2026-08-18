import 'dart:ui';

import 'package:waiter_app/core/enum/table_enum.dart';
import 'package:waiter_app/core/style/app_colors.dart';

extension TableStateColorX on TableState {
  Color get textColor {
    switch (this) {
      case TableState.free:
        return AppColors.tableStatusFreeText;
      case TableState.booked:
        return AppColors.tableStatusBookedText;
      case TableState.busy:
        return AppColors.tableStatusBusyText;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TableState.free:
        return AppColors.tableStatusFreeBackground;
      case TableState.booked:
        return AppColors.tableStatusBookedBackground;
      case TableState.busy:
        return AppColors.tableStatusBusyBackground;
    }
  }
}
