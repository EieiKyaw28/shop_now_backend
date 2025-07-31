import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/product/domain/product.dart';
import 'package:shop_now_backend/feature/product/domain/product_crud_model.dart';
import 'package:shop_now_backend/main.dart';

abstract class ProductRepository {
  Stream<List<Product>> fectchProduct();
  Future<Product> getProductById({required int id});
  Future<void> createProduct(ProductCrudModel category);
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Stream<List<Product>> fectchProduct() async* {
    try {
      final stream = supabase
          .from('product')
          .stream(primaryKey: ['id'])
          .map((data) => data.map((e) => Product.fromMap(e)).toList());

      yield* stream;
    } catch (e, st) {
      log("Product ===> $e $st");
    }
  }

  @override
  Future<Product> getProductById({required int id}) async {
    final result =
        await supabase.from('product').select().eq('id', id).single();

    return Product.fromMap(result);
  }

  @override
  Future<void> createProduct(ProductCrudModel product) async {
    try {
      if ((product.nameController?.text == null) &&
          (product.imageUrl == null)) {
        return;
      }

      await supabase.from('product').insert({
        'name': product.nameController?.text,
        'description': product.descriptionController?.text,
        'image': product.imageUrl,
        'category_id': product.categoryId,
        'type': 'active',
        'price': double.tryParse(product.priceController?.text ?? '0'),
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("product Error => $e $st");
    }
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final productListProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fectchProduct();
});

final getProductByIdProvider = FutureProvider.family<Product, int>((ref, id) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getProductById(id: id);
});
