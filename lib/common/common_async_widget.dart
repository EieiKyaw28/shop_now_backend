import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now_backend/constant/my_theme.dart';

class CommonAsyncWidget<T> extends StatelessWidget {
  const CommonAsyncWidget({
    super.key,
    required this.provider,
    required this.builder,
    this.loading,
    this.error,
  });

  final AsyncValue<T> provider;
  final Widget Function(T data) builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context) {
    return provider.when(
      data: builder,
      error:
          error ??
          (e, st) => Center(
            child: Text(
              "Error: $e $st",
              style: const TextStyle(color: Colors.red),
            ),
          ),
      loading:
          () =>
              loading ??
              const Center(
                child: CircularProgressIndicator(color: MyTheme.purpleShade1),
              ),
    );
  }
}
