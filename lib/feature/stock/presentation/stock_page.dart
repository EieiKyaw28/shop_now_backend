import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_async_widget.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_table.dart';

import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/constant/number_formatter.dart';
import 'package:shop_now_backend/feature/product/repository/product_repository.dart';

import 'package:shop_now_backend/feature/stock/presentation/stock_crud_view.dart';
import 'package:shop_now_backend/feature/stock/repository/stock_repository.dart';
import 'package:intl/intl.dart';

import 'package:side_sheet/side_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<StockPage> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  @override
  Widget build(BuildContext context) {
    final stockStream = ref.watch(stockListProvider);

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
                      "Stock",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.purpleShade1,
                      ),
                    ),
                    Row(
                      children: [
                        CommonButton(
                          width: 100,
                          onSubmit: () {
                            SideSheet.right(
                              sheetBorderRadius: 10,
                              width: MediaQuery.of(context).size.width * .4,
                              body: StockCrudView(),
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
                CommonAsyncWidget(
                  provider: stockStream,
                  builder: (stock) {
                    return Expanded(
                      child: CommonTable(
                        headers: [
                          'No.',
                          'Create Date',
                          'Product Name',
                          'Quantity',
                        ],
                        data: [
                          for (int i = 0; i < stock.length; i++)
                            [
                              Text("${i + 1}"),
                              Text(
                                stock[i].createdAt != null
                                    ? DateFormat(
                                      'yyyy-MMM-dd HH:mm a',
                                    ).format(stock[i].createdAt!)
                                    : '-',
                              ),
                              CommonAsyncWidget(
                                provider: ref.watch(
                                  getProductByIdProvider(
                                    stock[i].productId ?? 0,
                                  ),
                                ),
                                builder: (p) {
                                  return Text(p.name);
                                },
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    numberFormatter(
                                      stock[i].quantity.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
