import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/dashboard_card.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_state_builder.dart';
import 'package:waiter_app/core/style/app_colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HomePageStateBuilder(
        builder: (context, state) {
          String allTablesTotalPrice = state.allTablesTotalPrice.toString();
          int busyTables = state.busyTables;
          int bookedTables = state.bookedTables;
          int freeTables = state.freeTables;
          return Container(
              decoration: BoxDecoration(border: Border()),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          title: 'Забронированно ',
                          subtitle: '$bookedTables',
                          color: AppColors.tableStatusBookedText,
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          title: 'Свободно',
                          subtitle: '$freeTables',
                          color: AppColors.tableStatusFreeText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          title: 'Занято',
                          subtitle: '$busyTables',
                          color: AppColors.tableStatusBusyText,
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          title: 'Сумма чеков',
                          subtitle: '${allTablesTotalPrice.toString()}',
                          color: AppColors.forMoney,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        },
      ),
    );
  }
}