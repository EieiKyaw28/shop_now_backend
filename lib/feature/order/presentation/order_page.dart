import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_now_backend/common/common_async_widget.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_tab_button.dart';
import 'package:shop_now_backend/common/common_table.dart';

import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/order/repository/order_repository.dart';
import 'package:shop_now_backend/feature/product/presentation/product_crud_view.dart';
import 'package:shop_now_backend/feature/product/repository/product_repository.dart';

import 'package:side_sheet/side_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_tooltip/super_tooltip.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final orderStream = ref.watch(orderListProvider);

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
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order", style: TextStyle(fontWeight: FontWeight.bold)),
                  4.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              index = 0;
                              setState(() {});
                            },
                            child: TabButton(
                              label: 'Pending',
                              index: index,
                              isSelected: index == 0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              index = 1;
                              setState(() {});
                            },
                            child: TabButton(
                              label: 'Approved',
                              index: index,
                              isSelected: index == 1,
                            ),
                          ),
                        ],
                      ),
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
                  4.vGap,
                  Expanded(
                    child: TabBarView(
                      children: [
                        CommonAsyncWidget(
                          provider: orderStream,
                          builder: (data) {
                            return Expanded(
                              child: CommonTable(
                                headers: [
                                  'No.',
                                  'Date',
                                  'Invoice No.',
                                  'Order Product',
                                  "Order By",
                                ],
                                data: [
                                  for (int i = 0; i < data.length; i++) ...[
                                    [
                                      Text("${i + 1}"),
                                      Text(
                                        DateFormat(
                                          'dd-MM-yyyy hh:ss a',
                                        ).format(data[i].createdAt!),
                                      ),
                                      Text("INV00001"),

                                      CommonAsyncWidget(
                                        provider: ref.watch(
                                          orderProductListProvider(
                                            data[i].id ?? 0,
                                          ),
                                        ),
                                        builder: (orderProduct) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CommonAsyncWidget(
                                                provider: ref.watch(
                                                  getProductByIdProvider(
                                                    orderProduct
                                                            .firstOrNull
                                                            ?.productId ??
                                                        0,
                                                  ),
                                                ),
                                                builder: (d) {
                                                  return Text(d.name);
                                                },
                                              ),

                                              SuperTooltip(
                                                content: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Products"),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,

                                                      itemCount:
                                                          orderProduct.length,
                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        return CommonAsyncWidget(
                                                          provider: ref.watch(
                                                            getProductByIdProvider(
                                                              orderProduct
                                                                      .firstOrNull
                                                                      ?.productId ??
                                                                  0,
                                                            ),
                                                          ),
                                                          builder: (d) {
                                                            return SizedBox(
                                                              width: 500,
                                                              child: Text(
                                                                d.name,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),

                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,

                                                  child: Icon(
                                                    Icons.more_vert,
                                                    color: MyTheme.purpleShade1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),

                                      CommonAsyncWidget(
                                        provider: ref.watch(
                                          getCustomerByOrderIdProvider(
                                            data[i].id ?? 0,
                                          ),
                                        ),
                                        builder: (data) {
                                          return Text(data.name ?? "");
                                        },
                                      ),
                                    ],
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //  Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [

            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Order",
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: MyTheme.purpleShade1,
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: DefaultTabController(
            //                 length: 2,
            //                 child: TabBar(
            //                   isScrollable: false,
            //                   dividerColor: Colors.transparent,
            //                   indicatorWeight: 0.1,
            //                   tabs: [
            //                     Container(
            //                       width: 120,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(5),
            //                         color: MyTheme.purpleShade1,
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Text("Pending"),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: 120,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(5),
            //                         color: MyTheme.purpleShade1,
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Text("Approved"),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Spacer(),
            //             // CommonTextField(),
            //             CommonButton(
            //               width: 100,
            //               onSubmit: () {
            //                 SideSheet.right(
            //                   sheetBorderRadius: 10,
            //                   width: MediaQuery.of(context).size.width * .4,
            //                   body: ProductCrudView(),
            //                   context: context,
            //                 );
            //               },
            //               bgColor: MyTheme.purpleShade1,
            //               child: Text(
            //                 "Add",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     10.vGap,
            //     CommonAsyncWidget(
            //       provider: orderStream,
            //       builder: (data) {
            //         return Expanded(
            //           child: CommonTable(
            //             headers: [
            //               'No.',
            //               'Date',
            //               'Invoice No.',
            //               'Order Product',
            //               "Order By",
            //             ],
            //             data: [
            //               for (int i = 0; i < data.length; i++) ...[
            //                 [
            //                   Text("${i + 1}"),
            //                   Text(
            //                     DateFormat(
            //                       'dd-MM-yyyy hh:ss a',
            //                     ).format(data[i].createdAt!),
            //                   ),
            //                   Text("INV00001"),
            //                   Text("Order Products"),
            //                   CommonAsyncWidget(
            //                     provider: ref.watch(
            //                       getCustomerByOrderIdProvider(data[i].id ?? 0),
            //                     ),
            //                     builder: (data) {
            //                       return Text(data.name ?? "");
            //                     },
            //                   ),
            //                 ],
            //               ],
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
