import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_table.dart';

import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/product/presentation/product_crud_view.dart';

import 'package:shop_now_backend/feature/product/repository/product_repository.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final productStream = ref.watch(productListProvider);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: MyTheme.bgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.purpleShade1,
                      ),
                    ),
                    Row(
                      children: [
                        // CommonTextField(),
                        CommonButton(
                          width: 100,
                          onSubmit: () {
                            SideSheet.right(
                              sheetBorderRadius: 10,
                              width: MediaQuery.of(context).size.width * .4,
                              body: ProductCrudView(),
                              context: context,
                            );
                          },
                          bgColor: MyTheme.purpleShade1,
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                10.vGap,
                Expanded(
                  child: CommonTable(
                    headers: ['No.', 'Date', 'Invoice No.', "Order By"],
                    data: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
