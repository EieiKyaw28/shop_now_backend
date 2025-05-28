class Product {
  int? id;
  String name;
  String? image;
  String? description;
  double? price;
  int? categoryId;
  String type;
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.type,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      price: (map['price'] as num?)?.toDouble(),
      categoryId: map['category_id'] as int,
      type: map['type'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'type': type,
    };
  }
}
