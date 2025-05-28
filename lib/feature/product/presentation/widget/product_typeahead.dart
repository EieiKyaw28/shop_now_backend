import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_typeahead.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/category.dart';
import 'package:shop_now_backend/feature/category/repository/category_repository.dart';
import 'package:shop_now_backend/feature/product/domain/product.dart';
import 'package:shop_now_backend/feature/product/repository/product_repository.dart';

class ProductTypeahead extends ConsumerWidget {
  const ProductTypeahead({
    super.key,

    required this.controller,
    required this.onTap,
    this.hint = "Product",
    this.label,
  });
  final TextEditingController controller;

  final Function(Product) onTap;
  final String hint;
  final Widget? label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTypeAhead<Product>(
      label: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black),
      width: MediaQuery.of(context).size.width,
      controller: controller,
      suggestionsCallback: (search) async {
        final productList = await ref.read(productListProvider.future);
        return productList
            .where(
              (product) =>
                  product.name.toLowerCase().contains(search.toLowerCase()),
            )
            .toList();
      },
      itemBuilder: (context, product) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name),
          ),
        );
      },
      onSuggestionSelected: onTap,
    );
  }
}
