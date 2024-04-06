import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/base/presentation/base_view.dart';
import 'package:shop_app/base/presentation/static_ui/static_ui.dart';
import 'package:shop_app/extension/extension.dart';
import 'package:shop_app/features/shop/presentation/controller/product_provider.dart';

class TabBarPage extends BaseView {
  const TabBarPage({super.key});

  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    final tabBarController = ref.read(pageViewProvider.notifier);
    final indexState = ref.watch(pageViewProvider);
    tabBarController.onInit(() {});
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          currentIndex: indexState,
          onTap: tabBarController.onTap,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: StaticUI.bottomNavigationBarItems,
        ),
        body: PageView.builder(
          itemBuilder: (context, index) => StaticUI.listPage[index],
          physics: const NeverScrollableScrollPhysics(),
          itemCount: StaticUI.listPage.length,
          controller: tabBarController.pageController,
        ));
  }
}
