import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/base/presentation/static_ui/static_ui.dart';

class PageViewController extends StateNotifier<int> {
  final PageController pageController = PageController(initialPage: 0);

  PageViewController() : super(0);
  void pageChanged(int page) {
    state = page;
  }

  void onTap(int pageIndex) {
    state = pageIndex;
    if (pageIndex < StaticUI.listPage.length) {
      pageController.jumpToPage(pageIndex);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
