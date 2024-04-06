import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension StateNotifierInitExtension<T extends StateNotifier> on T {
  bool get isInitialized {
    if (!isInitializedMap.containsKey(T)) {
      isInitializedMap[T] = false;
    }
    return isInitializedMap[T]!;
  }

  set isInitialized(bool value) {
    isInitializedMap[T] = value;
  }

  static final Map<Type, bool> isInitializedMap = {};

  void onInit(VoidCallback callBack) {
    if (!isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callBack();
        isInitialized = true;
      });
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
