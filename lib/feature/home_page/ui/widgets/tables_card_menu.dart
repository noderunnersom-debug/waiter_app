import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/add_dish_section.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_state_builder.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/list_section.dart';
import 'package:waiter_app/core/style/app_button_styles.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/table_information.dart';
import '../../domain/entity/table_entity.dart';
import '../bloc/home_page_bloc.dart';

class TablesCardMenu extends StatelessWidget {
  final String tableId;

  const TablesCardMenu({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomePageStateBuilder(
          builder: (context, state) {
            final table = _findTable(state.tables, tableId);

            if (table == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Стол больше не существует',
                      style: AppTextStyle.bodyLarge(color: AppColors.textMidl),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Закрыть'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.textMidl,
                    ),
                    tooltip: 'Удалить стол',
                    onPressed: () => _confirmDelete(context, table),
                  ),
                ),
                TabelInformation(table: table),
                Expanded(
                  flex: 3,
                  child: ListSection(orders: table.orders, tableId: tableId),
                ),
                Expanded(
                  flex: 2,
                  child: AddDishSection(
                    onTap: (order) {
                      context.read<HomePageBloc>().add(
                        AddOrderEvent(tableId: tableId, order: order),
                      );
                    },
                  ),
                ),
                _PaymentSection(
                  totalPrice: table.totalOrderPrice,
                  onTap: () {
                    context.read<HomePageBloc>().add(
                      ConfirmTableEvent(tableId: tableId),
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Показывает нужный диалог в зависимости от состояния стола —
  /// проверка идёт по данным, которые уже есть на руках (table.orders),
  /// без похода в BLoC. Так UI сам решает, что показать пользователю,
  /// а не ждёт ErrorState, который лишний раз дублировался бы во всех
  /// трёх местах, подписанных на HomePageStateBuilder одновременно.
  void _confirmDelete(BuildContext context, GeneralTableEntity table) {
    if (table.orders.isNotEmpty) {
      _showBlockedDialog(context);
      return;
    }
    _showConfirmDialog(context, table);
  }

  void _showBlockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Нельзя удалить стол'),
          content: const Text(
            'Стол с открытыми заказами удалить нельзя.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Понятно'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmDialog(BuildContext context, GeneralTableEntity table) {
    final bloc = context.read<HomePageBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Удалить стол?'),
          content: Text(
            '${table.name} будет удалён без возможности восстановления.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                bloc.add(DeleteTableEvent(tableId: table.id));
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Удалить',
                style: TextStyle(color: AppColors.forMoney),
              ),
            ),
          ],
        );
      },
    );
  }

  GeneralTableEntity? _findTable(List<GeneralTableEntity> tables, String id) {
    for (final table in tables) {
      if (table.id == id) return table;
    }
    return null;
  }
}

class _PaymentSection extends StatelessWidget {
  final Function() onTap;
  final double totalPrice;

  const _PaymentSection({required this.onTap, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Итого к оплате',
                style: AppTextStyle.headlineSmoll(color: AppColors.textMidl),
              ),
              Spacer(),
              Text(
                '${totalPrice.toString()}₽',
                style: AppTextStyle.priceLarge(color: AppColors.forMoney),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 75,
              width: double.infinity,
              child: ElevatedButton(
                style: AppButtonStyles.settlingTheBill,
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      color: AppColors.backgroundLight,
                    ),
                    Text(
                      ' Закрыть счет',
                      style: AppTextStyle.buttonLarge(
                        color: AppColors.backgroundLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}