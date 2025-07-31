class Customer {
  int? id;
  String? customerId;
  String? name;

  Customer({required this.id, required this.customerId, required this.name});

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      customerId: map['customer_id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'customer_id': customerId, 'name': name};
  }
}
