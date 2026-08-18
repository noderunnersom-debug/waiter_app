import 'package:flutter/material.dart';
import 'package:waiter_app/feature/home_page/domain/entity/order_entity.dart';
import 'package:waiter_app/core/style/app_button_styles.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_input_decoration.dart';
import 'package:waiter_app/core/style/app_text_style.dart';

class AddDishSection extends StatefulWidget {
  final Function(OrderEntity) onTap;

  const AddDishSection({super.key, required this.onTap});

  @override
  State<AddDishSection> createState() => _AddDishSectionState();
}

class _AddDishSectionState extends State<AddDishSection> {
  final TextEditingController nameDishController = TextEditingController();
  final TextEditingController priceDishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundHard,
      child: Center(
        child: Container(
          color: AppColors.backgroundMidl,
          height: 200,
          width: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Новая позиция',
                      style: AppTextStyle.bodyMediumBold(
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameDishController,
                          decoration: AppInputDecoration.textField(
                            hintText: 'Название блюда...',
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: priceDishController,
                          decoration: AppInputDecoration.textField(
                            hintText: 'Цена',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppButtonStyles.orderButton,
                    onPressed: () {
                      widget.onTap(
                        OrderEntity(
                          totalPrice:
                              double.tryParse(priceDishController.text) ?? 0,
                          name: nameDishController.text,
                          price: double.tryParse(priceDishController.text) ?? 0,
                        ),
                      );
                    },
                    child: Text(
                      '+ Добавить в заказ',
                      style: AppTextStyle.buttonSmall(
                        color: AppColors.backgroundLight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
