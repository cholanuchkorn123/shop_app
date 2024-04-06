import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/features/shop/presentation/controller/usecase_provider.dart';
import 'package:shop_app/features/shop/presentation/view/page/detail_page.dart';
import 'package:shop_app/features/shop/presentation/view/widget/card_product_widget.dart';
import '/base/presentation/base_view.dart';
import '/extension/extension.dart';
import '/features/shop/presentation/controller/product_provider.dart';

class HomePage extends BaseView {
  const HomePage({super.key});

  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    final controller = ref.read(homeViewProvider.notifier);

    controller.onInit(
      () async {
        await controller.upDateState();
      },
    );

    final state = ref.watch(homeViewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommendation',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 0.8),
            itemCount: ref.watch(homeViewProvider).length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailPage(product: state[index]))),
                child: CardProduct(
                  state[index],
                  ref.read(addProductProvider),
                  ref.read(deleteProductProvider),
                ),
              );
            }),
      ),
    );
  }
}
