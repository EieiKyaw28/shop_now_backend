class OrderProduct {
  int? id;
  int? orderById;
  int? orderId;
  int? productId;
  int? quantity;
  DateTime? createdAt;

  OrderProduct({
    required this.id,
    required this.orderById,
    required this.orderId,
    required this.productId,
    required this.quantity,

    required this.createdAt,
  });

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      id: map['id'] as int,
      orderById: map['order_by_id'] as int,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_by_id': orderById,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'create_at ': createdAt,
    };
  }
}
