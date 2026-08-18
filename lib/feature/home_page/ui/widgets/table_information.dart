import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/core/enum/table_enum.dart';
import 'package:waiter_app/core/extensions/table_state_extensions.dart';
import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';
import 'package:waiter_app/core/style/app_button_styles.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';

class TabelInformation extends StatelessWidget {
  final GeneralTableEntity table;

  const TabelInformation({super.key, required this.table});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.backgroundLight),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        table.name,
                        style: AppTextStyle.headlineLarge(
                          color: AppColors.textDark,
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_outline_outlined,
                              color: AppColors.textMidl,
                            ),
                            Text(
                              "Управление заказом",
                              style: AppTextStyle.bodyLarge(
                                color: AppColors.textMidl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: table.status.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: table.status.textColor),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.adjust_rounded,
                            color: table.status.textColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          table.status == TableState.free
                              ? 'Свободен'
                              : table.status == TableState.booked
                              ? 'Забронирован'
                              : 'Занят',
                          style: AppTextStyle.buttonSmall(
                            color: table.status.textColor,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _TableStatus(
                status: 'Свободен',
                isAlive: table.status == TableState.free,
                tableId: table.id,
              ),
              _TableStatus(
                status: 'Забронирован',
                isAlive: table.status == TableState.booked,
                tableId: table.id,
              ),
              _TableStatus(
                status: 'Занят',
                isAlive: table.status == TableState.busy,
                tableId: table.id,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TableStatus extends StatelessWidget {
  final String status;
  final bool isAlive;
  final String tableId;

  const _TableStatus({
    required this.status,
    required this.isAlive,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50,
          height: 40,
          child: ElevatedButton(
            style: isAlive
                ? buttonStyleForStatus(status)
                : AppButtonStyles.menuStatus,
            onPressed: () {
              if (!isAlive) {
                context.read<HomePageBloc>().add(
                  ChangeTableStatusEvent(
                    tableId: tableId,
                    newTableState: tableStateFromString(status),
                  ),
                );
              }
            },
            child: Text(
              status,
              style: AppTextStyle.buttonSmall(color: AppColors.textDark),
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle buttonStyleForStatus(String status) {
    switch (status) {
      case 'Свободен':
        return AppButtonStyles.menuStatusFree;
      case 'Забронирован':
        return AppButtonStyles.menuStatusBooked;
      case 'Занят':
        return AppButtonStyles.menuStatusBusy;
      default:
        return AppButtonStyles.menuStatus;
    }
  }

  TableState tableStateFromString(String status) {
    switch (status) {
      case 'Свободен':
        return TableState.free;
      case 'Забронирован':
        return TableState.booked;
      case 'Занят':
        return TableState.busy;
      default:
        throw TableState.free;
    }
  }
}
