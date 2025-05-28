import 'dart:io';

import 'package:flutter/widgets.dart';

class ProductCrudModel {
  final String? id;
  final TextEditingController? nameController;
  final TextEditingController? descriptionController;
  final TextEditingController? priceController;
  final String? imageUrl;
  final File? imageFile;
  final DateTime? createdAt;
  final int? categoryId;
  final TextEditingController? categoryController;

  const ProductCrudModel({
    this.id,
    this.nameController,
    this.descriptionController,
    this.priceController,
    this.imageUrl,
    this.imageFile,
    this.createdAt,
    this.categoryController,
    this.categoryId,
  });

  static ProductCrudModel initial = ProductCrudModel(
    id: null,
    nameController: TextEditingController(),
    descriptionController: TextEditingController(),
    priceController: TextEditingController(),
    imageUrl: null,
    imageFile: null,
    createdAt: null,
    categoryController: TextEditingController(),
    categoryId: null,
  );

  ProductCrudModel copyWith({
    String? id,
    TextEditingController? nameController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
    String? imageUrl,
    required File? imageFile,
    DateTime? createdAt,
    int? categoryId,
    TextEditingController? categoryController,
  }) {
    return ProductCrudModel(
      id: id ?? this.id,
      nameController: nameController ?? this.nameController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      priceController: priceController ?? this.priceController,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile,
      createdAt: createdAt ?? this.createdAt,
      categoryId: categoryId ?? this.categoryId,
      categoryController: categoryController ?? this.categoryController,
    );
  }

  factory ProductCrudModel.fromJson(Map<String, dynamic> json) {
    return ProductCrudModel(
      id: json['id'] ?? '',
      nameController: json['nameController'] ?? '',
      descriptionController: json['descriptionController'] ?? '',
      priceController: json['priceController'],
      imageUrl: json['imageUrl'] ?? '',
      imageFile: json['imageFile'],
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      categoryId: json['categoryId'],
      categoryController: json['categoryController'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameController': nameController,
      'description': descriptionController,
      'priceController': priceController,
      'imageUrl': imageUrl,
      'createdAt': createdAt!.toIso8601String(),
      'imageFile': imageFile,
      'categoryId': categoryId,
      'categoryController': categoryController,
    };
  }

  @override
  String toString() {
    return 'ProductCrudModel(id: $id, nameController: $nameController)';
  }
}
