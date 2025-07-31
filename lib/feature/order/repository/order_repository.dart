import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/order/domain/customer.dart';
import 'package:shop_now_backend/feature/order/domain/order.dart';
import 'package:shop_now_backend/feature/order/domain/order_product.dart';
import 'package:shop_now_backend/main.dart';

abstract class OrderRepository {
  Stream<List<Order>> fetchOrder();
  Stream<List<OrderProduct>> fetchOrderProductsByOrderId({required int id});
  Future<Order> getOrderProductByOrderId({required int id});
  Future<Customer> getCustomerByOrderId({required int id});
}

class OrderRepositoryImpl implements OrderRepository {
  @override
  Stream<List<Order>> fetchOrder() async* {
    try {
      final stream = supabase
          .from('order')
          .stream(primaryKey: ['id'])
          .map((data) => data.map((e) => Order.fromMap(e)).toList());

      yield* stream;
    } catch (e, st) {
      log("Order ===> $e $st");
    }
  }

  @override
  Stream<List<OrderProduct>> fetchOrderProductsByOrderId({required int id}) {
    try {
      final stream =
          supabase.from('order_product').stream(primaryKey: ['id']).execute();

      return stream.map((rows) {
        final allProducts = rows.map((e) => OrderProduct.fromMap(e)).toList();

        return allProducts.where((p) => p.orderId == id).toList();
      });
    } catch (e, st) {
      log("Order ===> $e $st");
      rethrow;
    }
  }

  @override
  Future<Order> getOrderProductByOrderId({required int id}) async {
    final result =
        await supabase.from('product').select().eq('id', id).single();

    return Order.fromMap(result);
  }

  @override
  Future<Customer> getCustomerByOrderId({required int id}) async {
    final result =
        await supabase.from('customer').select().eq('id', id).single();

    return Customer.fromMap(result);
  }
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl();
});

final orderListProvider = StreamProvider<List<Order>>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.fetchOrder();
});

final orderProductListProvider = StreamProvider.family<List<OrderProduct>,int>((ref,id) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.fetchOrderProductsByOrderId(id: id);
});

final getOrderProductByOrderIdProvider = FutureProvider.family<Order, int>((
  ref,
  id,
) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.getOrderProductByOrderId(id: id);
});

final getCustomerByOrderIdProvider = FutureProvider.family<Customer, int>((
  ref,
  id,
) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.getCustomerByOrderId(id: id);
});
