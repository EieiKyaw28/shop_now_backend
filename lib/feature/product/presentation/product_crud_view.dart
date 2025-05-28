import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_async_widget.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_textfield.dart';
import 'package:shop_now_backend/common/image_picker.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/controller/category_controller.dart';
import 'package:shop_now_backend/feature/category/domain/common_query_model.dart';
import 'package:shop_now_backend/feature/category/presentation/widdget/category_typeahead.dart';
import 'package:shop_now_backend/feature/product/controller/product_crud_controller.dart';

class ProductCrudView extends ConsumerStatefulWidget {
  const ProductCrudView({super.key});

  @override
  ConsumerState<ProductCrudView> createState() => _ProductCrudViewState();
}

class _ProductCrudViewState extends ConsumerState<ProductCrudView> {
  @override
  Widget build(BuildContext context) {
    final family = CommonQueryModel();
    final provider = ref.watch(productCrudControllerProvider(family));
    final func = ref.read(productCrudControllerProvider(family).notifier);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CommonAsyncWidget(
        provider: provider,
        builder: (product) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Product",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.purpleShade1,
                ),
              ),
              Divider(),
              5.vGap,
              ImagePicker(
                selectedImage: product.imageFile,
                onImageSelected: (file) {
                  func.uploadImage(imageFile: file);
                },
                onImageDelete: func.deleteImage,
              ),

              CommonTextField(
                width: double.infinity,

                hintText: "Product Name",
                controller: product.nameController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              10.vGap,
              CommonTextField(
                width: double.infinity,

                hintText: "Description",
                controller: product.descriptionController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              10.vGap,
              CommonTextField(
                width: double.infinity,

                hintText: "Price",
                controller: product.priceController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              10.vGap,
              CategoryTypeAhead(
                controller:
                    product.categoryController ?? TextEditingController(),
                onTap: func.categoryOnSelected,
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                    width: 120,
                    onSubmit: func.createProduct,
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
