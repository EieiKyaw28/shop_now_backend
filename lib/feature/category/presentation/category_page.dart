import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_async_widget.dart';
import 'package:shop_now_backend/common/common_button.dart';

import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/category/presentation/cateogry_create_view.dart';
import 'package:shop_now_backend/feature/category/presentation/widdget/category_component.dart';
import 'package:shop_now_backend/feature/category/repository/category_repository.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final categoryStream = ref.watch(categoryListProvider);
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
                      "Category",
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
                              body: CateogryCreateView(),
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
                  child: CommonAsyncWidget(
                    provider: categoryStream,
                    builder: (category) {
                      return GridView.builder(
                        itemCount: category.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 3 / 2,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (context, index) {
                          final item = category[index];
                          return CategoryComponent(category: item);
                        },
                      );
                    },
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
