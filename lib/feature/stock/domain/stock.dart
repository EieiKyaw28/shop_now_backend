class Stock {
  int? id;

  String? status;
  double? quantity;
  int? productId;
  DateTime? createdAt;

  Stock({
    required this.id,
    required this.status,
    required this.quantity,
    required this.productId,
    required this.createdAt,
  });

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map['id'] as int,

      status: map['status'] as String,
      quantity: (map['quantity'] as num?)?.toDouble(),
      productId: map['product_id'] as int,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'status': status,
      'quantity': quantity,
      'product_id': productId,
      'created_at': createdAt,
    };
  }
}
