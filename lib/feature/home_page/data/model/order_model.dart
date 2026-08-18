import 'package:hive_flutter/hive_flutter.dart';
part 'order_model.g.dart';

@HiveType(typeId: 1)
class OrderModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final double? totalPrice;

  OrderModel({
    required this.name, required this.price, required this.totalPrice
  });
}