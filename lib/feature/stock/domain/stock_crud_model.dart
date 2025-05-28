import 'dart:io';

import 'package:flutter/widgets.dart';

class StockCrudModel {
  final String? id;
  final TextEditingController? productNameController;
  final TextEditingController? qtyController;

  final int? productId;

  const StockCrudModel({
    this.id,
    this.productNameController,
    this.qtyController,

    this.productId,
  });

  static StockCrudModel initial = StockCrudModel(
    id: null,
    productNameController: TextEditingController(),
    qtyController: TextEditingController(),

    productId: null,
  );

  StockCrudModel copyWith({
    String? id,
    TextEditingController? productNameController,
    TextEditingController? qtyController,

    int? productId,
  }) {
    return StockCrudModel(
      id: id ?? this.id,
      productNameController:
          productNameController ?? this.productNameController,
      qtyController: qtyController ?? this.qtyController,

      productId: productId ?? this.productId,
    );
  }

  factory StockCrudModel.fromJson(Map<String, dynamic> json) {
    return StockCrudModel(
      id: json['id'] ?? '',
      productNameController: json['productNameController'] ?? '',
      qtyController: json['qtyController'] ?? '',

      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productNameController': productNameController,
      'description': qtyController,

      'productId': productId,
    };
  }

  @override
  String toString() {
    return 'StockCrudModel(id: $id, productNameController: $productNameController)';
  }
}
