import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/core/extensions/table_state_extensions.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';
import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';
import 'package:waiter_app/core/style/app_button_styles.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';

import '../../../../core/enum/table_enum.dart';

class TabelesCard extends StatelessWidget {
  final HomePageBloc bloc;
  final GeneralTableEntity table;
  final int orderCount;
  final Function(String tableId) onTableTap;

  const TabelesCard({
    required this.orderCount,
    required this.onTableTap,
    super.key,
    required this.table,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<HomePageBloc, HomePageBlocState>(
        builder: (context, state) {
          return ElevatedButton(
            style: AppButtonStyles.tablesCardButton,
            onPressed: () {
              onTableTap(table.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.forBorderGrey,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        table.name,
                                        style: AppTextStyle.headlineLarge(
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.adjust_sharp,
                                    color: table.status.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        table.status == TableState.free
                                            ? 'Свободен'
                                            : table.status == TableState.booked
                                            ? 'Забронирован'
                                            : 'Занят',
                                        style: AppTextStyle.headlineSmoll(
                                          color: table.status.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.aod_outlined,
                                  color: AppColors.textMidl,
                                ),
                                Text(
                                  orderCount.toString(),
                                  style: AppTextStyle.headlineSmoll(
                                    color: AppColors.textMidl,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(Icons.people, color: AppColors.textMidl),
                                Text(
                                  '-',
                                  style: AppTextStyle.headlineSmoll(
                                    color: AppColors.textMidl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
