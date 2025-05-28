import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/common_query_model.dart';
import 'package:shop_now_backend/feature/product/domain/product.dart';

import 'package:shop_now_backend/feature/stock/domain/stock_crud_model.dart';
import 'package:shop_now_backend/feature/stock/repository/stock_repository.dart';

class StockCrudController
    extends AutoDisposeFamilyAsyncNotifier<StockCrudModel, CommonQueryModel> {
  @override
  build(CommonQueryModel? arg) {
    final model = StockCrudModel(
      productNameController: TextEditingController(),
      qtyController: TextEditingController(),
    );
    return model;
  }

  Future<void> productOnSelected(Product c) async {
    state = AsyncData(
      state.value!.copyWith(
        productId: c.id,
        productNameController: TextEditingController(text: c.name),
      ),
    );
  }

  Future<void> createStock() async {
    final s = state.value!;
    ref.read(stockRepositoryProvider).createStock(s);
  }
}

final stockCrudControllerProvider = AsyncNotifierProvider.autoDispose
    .family<StockCrudController, StockCrudModel, CommonQueryModel>(() {
      return StockCrudController();
    });
