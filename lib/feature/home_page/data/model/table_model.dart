import 'package:hive_flutter/hive_flutter.dart';
import 'package:waiter_app/feature/home_page/data/model/order_model.dart';
part 'table_model.g.dart';

@HiveType(typeId: 0)
class TableModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int statusIndex;

  @HiveField(2)
  final List<OrderModel> orders;

  @HiveField(3)
  final String id;

  TableModel({
    required this.id,
    required this.name,
    required this.statusIndex,
    required this.orders,
  });
}
