import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:shop_now_backend/common/common_cached_network.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/image_string.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/category/domain/category.dart';

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CommonCachedNetwork(
                image: category.image,
                placeholder: ImageString.categoryIcon,
              ),
            ),
            10.hGap,
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
