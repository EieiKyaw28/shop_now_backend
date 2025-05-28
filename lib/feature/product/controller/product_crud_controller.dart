import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shop_now_backend/common/common_storage_image.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/category.dart';
import 'package:shop_now_backend/feature/category/domain/common_query_model.dart';
import 'package:shop_now_backend/feature/product/domain/product_crud_model.dart';
import 'package:shop_now_backend/feature/product/repository/product_repository.dart';

class ProductCrudController
    extends AutoDisposeFamilyAsyncNotifier<ProductCrudModel, CommonQueryModel> {
  @override
  build(CommonQueryModel? arg) {
    final model = ProductCrudModel(
      nameController: TextEditingController(),
      descriptionController: TextEditingController(),
      priceController: TextEditingController(),
    );
    return model;
  }

  Future<void> uploadImage({required File? imageFile}) async {
    state = AsyncData(state.value!.copyWith(imageFile: imageFile));

    if (imageFile != null) {
      final image = await CommonStoreImage().uploadAvatar(
        bucketName: 'products',
        avatarFile: imageFile,
      );
      state = AsyncData(
        state.value!.copyWith(
          imageUrl: image,
          imageFile: state.value?.imageFile,
        ),
      );
    }
  }

  Future<void> deleteImage() async {
    state = AsyncData(state.value!.copyWith(imageFile: null));
  }

  Future<void> categoryOnSelected(Category c) async {
    state = AsyncData(
      state.value!.copyWith(
        imageFile: state.value?.imageFile,
        categoryId: c.id,
        categoryController: TextEditingController(text: c.name),
      ),
    );
  }

  Future<void> createProduct() async {
    final p = state.value!;
    log("Product ==> ${p.priceController?.text}");
    await ref.read(productRepositoryProvider).createProduct(p);
  }
}

final productCrudControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ProductCrudController, ProductCrudModel, CommonQueryModel>(() {
      return ProductCrudController();
    });
