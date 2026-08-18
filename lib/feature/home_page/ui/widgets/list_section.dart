import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/feature/home_page/domain/entity/order_entity.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';
import 'package:waiter_app/core/style/app_borders.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';

class ListSection extends StatelessWidget {
  final List<OrderEntity> orders;
  final String tableId;

  const ListSection({super.key, required this.orders, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundHard,
        border: Border(
          bottom: AppBorders.width1(color: AppColors.screenSplitting),
        ),
      ),
      child: orders.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.dining_rounded, color: AppColors.textMidl),
                      Text(
                        'Cписок блюд',
                        style: AppTextStyle.headlineMedium(
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  child: Container(
                    color: AppColors.backgroundMidl,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dining_rounded,
                            color: AppColors.textMidl,
                            size: 60,
                          ),
                          Text(
                            'Стол пуст',
                            style: AppTextStyle.headlineMedium(
                              color: AppColors.textMidl,
                            ),
                          ),
                          Text(
                            'Добавьте блюда ниже',
                            style: AppTextStyle.bodyMedium(
                              color: AppColors.textMidl,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (ctx, index) {
                return _AddedDish(
                  order: orders[index],
                  tableId: tableId,
                  orderIndex: index,
                );
              },
            ),
    );
  }
}

class _AddedDish extends StatelessWidget {
  final OrderEntity order;
  final String tableId;
  final int orderIndex;

  const _AddedDish({
    required this.order,
    required this.tableId,
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 3,
            bottom: 3,
            left: 15,
            right: 15,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              border: Border.all(color: AppColors.forBorderGrey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      order.name,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(order.price.toString()),
                  IconButton(
                    onPressed: () {
                      context.read<HomePageBloc>().add(
                        DeleteOrderEvent(
                          order: order,
                          tableId: tableId,
                          orderIndex: orderIndex,
                        ),
                      );
                    },
                    icon: Icon(Icons.delete_forever),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
