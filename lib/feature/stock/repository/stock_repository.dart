import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_now_backend/feature/stock/domain/stock.dart';
import 'package:shop_now_backend/feature/stock/domain/stock_crud_model.dart';
import 'package:shop_now_backend/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StockRepository {
  Stream<List<Stock>> fetchStock();
  Future<void> createStock(StockCrudModel stock);
}

class StockRepositoryImpl implements StockRepository {
  final supabase = Supabase.instance.client;

  @override
  Stream<List<Stock>> fetchStock() async* {
    try {
      final stream = supabase
          .from('stock')
          .stream(primaryKey: ['id'])
          .map((data) => data.map((e) => Stock.fromMap(e)).toList());

      yield* stream;
    } catch (e, st) {
      log("Stock ===> $e $st");
    }
  }

  @override
  Future<void> createStock(StockCrudModel stock) async {
    try {
      if ((stock.qtyController?.text == null) &&
          (stock.productNameController == null)) {
        return;
      }

      await supabase.from('stock').insert({
        'quantity': double.tryParse(stock.qtyController?.text ?? "0"),

        'product_id': stock.productId,
        'status': 'in_stock',

        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Stock Error => $e $st");
    }
  }
}

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepositoryImpl();
});

final stockListProvider = StreamProvider<List<Stock>>((ref) {
  final repo = ref.watch(stockRepositoryProvider);
  return repo.fetchStock();
});
