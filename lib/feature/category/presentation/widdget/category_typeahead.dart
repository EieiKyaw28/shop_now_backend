import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_typeahead.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/category.dart';
import 'package:shop_now_backend/feature/category/repository/category_repository.dart';

class CategoryTypeAhead extends ConsumerWidget {
  const CategoryTypeAhead({
    super.key,

    required this.controller,
    required this.onTap,
    this.hint = "Category",
    this.label,
  });
  final TextEditingController controller;

  final Function(Category) onTap;
  final String hint;
  final Widget? label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTypeAhead<Category>(
      label: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black),
      width: MediaQuery.of(context).size.width,
      controller: controller,
      suggestionsCallback: (search) async {
        final categoryList = await ref.read(categoryListProvider.future);
        return categoryList
            .where(
              (category) =>
                  category.name.toLowerCase().contains(search.toLowerCase()),
            )
            .toList();
      },
      itemBuilder: (context, category) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category.name),
          ),
        );
      },
      onSuggestionSelected: onTap,
    );
  }
}
