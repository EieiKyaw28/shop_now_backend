class Order {
  int? id;
  int? orderById;
  double? totalAmount;
  String? type;
  DateTime? createdAt;

  Order({
    required this.id,
    required this.orderById,
    required this.totalAmount,
    required this.type,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      orderById: map['order_by_id'] as int,
      totalAmount: (map['total_amount'] as num?)?.toDouble(),
      type: map['type'] as String,
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
      'total_amount': totalAmount,
      'type': type,
      'create_at': createdAt,
    };
  }
}
