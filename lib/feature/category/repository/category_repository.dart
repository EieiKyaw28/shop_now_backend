import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/category.dart';
import 'package:shop_now_backend/feature/category/domain/category_crud_model.dart';
import 'package:shop_now_backend/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRepository {
  Stream<List<Category>> fectchCategory();
  Future<void> createCategory(CategoryCrudModel category);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final supabase = Supabase.instance.client;

  @override
  Stream<List<Category>> fectchCategory() async* {
    final stream = supabase
        .from('category')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((e) => Category.fromMap(e)).toList());

    yield* stream;
  }

  @override
  Future<void> createCategory(CategoryCrudModel category) async {
    try {
      if ((category.nameController?.text == null) &&
          (category.imageUrl == null)) {
        return;
      }

      await supabase.from('category').insert({
        'name': category.nameController?.text,
        'image': category.imageUrl,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Category Error => $e $st");
    }
  }
}

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl();
});

final categoryListProvider = StreamProvider<List<Category>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.fectchCategory();
});
