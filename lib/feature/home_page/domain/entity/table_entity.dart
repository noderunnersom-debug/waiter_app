import '../../../../core/enum/table_enum.dart';
import 'order_entity.dart';

class GeneralTableEntity {
  final String id;
  final String name;
  final TableState status;
  final List<OrderEntity> orders;

  const GeneralTableEntity({
    required this.id,
    this.orders = const [],
    required this.name,
    required this.status,
  });

  GeneralTableEntity copyWith({List<OrderEntity>? orders, TableState? status}) {
    return GeneralTableEntity(
      id: id,
      orders: orders ?? this.orders,
      name: name,
      status: status ?? this.status,
    );
  }

  double get totalOrderPrice {
    return orders.fold<double>(0.0, (sum, order) => sum + order.price);
  }
}
