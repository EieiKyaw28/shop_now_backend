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

class CateogryCreateView extends ConsumerStatefulWidget {
  const CateogryCreateView({super.key});

  @override
  ConsumerState<CateogryCreateView> createState() => _CateogryCreateViewState();
}

class _CateogryCreateViewState extends ConsumerState<CateogryCreateView> {
  @override
  Widget build(BuildContext context) {
    final family = CommonQueryModel();
    final provider = ref.watch(categoryCreateControllerProvider(family));
    final func = ref.read(categoryCreateControllerProvider(family).notifier);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CommonAsyncWidget(
        provider: provider,
        builder: (category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.purpleShade1,
                ),
              ),
              Divider(),
              5.vGap,
              ImagePicker(
                selectedImage: category.imageFile,
                onImageSelected: (file) {
                  func.uploadImage(imageFile: file);
                },
                onImageDelete: func.deleteImage,
              ),
              10.vGap,
              CommonTextField(
                width: double.infinity,
                height: 60,
                hintText: "Category Name",
                controller: category.nameController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                    width: 120,
                    onSubmit: func.createCategory,
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
