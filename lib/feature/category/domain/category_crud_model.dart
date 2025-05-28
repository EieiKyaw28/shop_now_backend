import 'dart:io';

import 'package:flutter/widgets.dart';

class CategoryCrudModel {
  final String? id;
  final TextEditingController? nameController;
  final String? description;
  final String? imageUrl;
  final File? imageFile;
  final DateTime? createdAt;

  const CategoryCrudModel({
    this.id,
    this.nameController,
    this.description,
    this.imageUrl,
    this.imageFile,
    this.createdAt,
  });

  // Default initialized instance
  static CategoryCrudModel initial = CategoryCrudModel(
    id: null,
    nameController: TextEditingController(),
    description: null,
    imageUrl: null,
    imageFile: null,
    createdAt: null,
  );

  // CopyWith
  CategoryCrudModel copyWith({
    String? id,
    TextEditingController? nameController,
    String? description,
    String? imageUrl,
    required File? imageFile,
    DateTime? createdAt,
  }) {
    return CategoryCrudModel(
      id: id ?? this.id,
      nameController: nameController ?? this.nameController,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // From JSON
  factory CategoryCrudModel.fromJson(Map<String, dynamic> json) {
    return CategoryCrudModel(
      id: json['id'] ?? '',
      nameController: json['nameController'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      imageFile: json['imageFile'],
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameController': nameController,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt!.toIso8601String(),
      'imageFile': imageFile,
    };
  }

  @override
  String toString() {
    return 'CategoryCrudModel(id: $id, nameController: $nameController)';
  }
}
