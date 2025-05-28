import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shop_now_backend/common/common_storage_image.dart';
import 'package:shop_now_backend/feature/category/domain/category_crud_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/feature/category/domain/common_query_model.dart';
import 'package:shop_now_backend/feature/category/repository/category_repository.dart';

class CategoryCreateController
    extends
        AutoDisposeFamilyAsyncNotifier<CategoryCrudModel, CommonQueryModel> {
  @override
  build(CommonQueryModel? arg) {
    final model = CategoryCrudModel(nameController: TextEditingController());
    return model;
  }

  Future<void> uploadImage({required File? imageFile}) async {
    state = AsyncData(state.value!.copyWith(imageFile: imageFile));

    if (imageFile != null) {
      final image = await CommonStoreImage().uploadAvatar(
        bucketName: 'categories',
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

  Future<void> createCategory() async {
    final c = state.value!;
    log("Name ===> ${c.nameController?.text} | ${c.imageUrl}");
    ref.read(categoryRepositoryProvider).createCategory(c);
  }
}

final categoryCreateControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CategoryCreateController, CategoryCrudModel, CommonQueryModel>(() {
      return CategoryCreateController();
    });
