class OrderEntity {
  final String name;
  final double price;
  final double? totalPrice;

  const OrderEntity({required this.price, this.totalPrice, required this.name});

  OrderEntity copyWith({String? name, double? price, double? totalPrice}) {
    return OrderEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
