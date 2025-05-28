import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_now_backend/common/common_cached_network.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/image_string.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/constant/number_formatter.dart';
import 'package:shop_now_backend/feature/product/domain/product.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * .5,
                child: CommonCachedNetwork(
                  image: product.image ?? "",
                  placeholder: ImageString.productIcon,
                ),
              ),
            ),
            5.vGap,
            Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyTheme.purpleShade1,
              ),
            ),
            5.vGap,
            Text(
              "${numberFormatter(product.price.toString())} Ks",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
