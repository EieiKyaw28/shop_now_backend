import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_async_widget.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_textfield.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/common_query_model.dart';

import 'package:shop_now_backend/feature/product/presentation/widget/product_typeahead.dart';
import 'package:shop_now_backend/feature/stock/controller/stock_crud_controller.dart';

class StockCrudView extends ConsumerStatefulWidget {
  const StockCrudView({super.key});

  @override
  ConsumerState<StockCrudView> createState() => _StockCrudViewState();
}

class _StockCrudViewState extends ConsumerState<StockCrudView> {
  @override
  Widget build(BuildContext context) {
    final family = CommonQueryModel();
    final provider = ref.watch(stockCrudControllerProvider(family));
    final func = ref.read(stockCrudControllerProvider(family).notifier);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CommonAsyncWidget(
        provider: provider,
        builder: (stock) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Stock",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.purpleShade1,
                ),
              ),
              Divider(),
              5.vGap,

              ProductTypeahead(
                controller:
                    stock.productNameController ?? TextEditingController(),
                onTap: func.productOnSelected,
              ),
              10.vGap,

              10.vGap,
              CommonTextField(
                width: double.infinity,

                hintText: "Quantity",
                controller: stock.qtyController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              10.vGap,

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                    width: 120,
                    onSubmit: func.createStock,
                    bgColor: MyTheme.purpleShade1,
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
