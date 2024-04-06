import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/features/shop/presentation/view/widget/card_tile_with_quantity.dart';
import 'package:shop_app/features/shop/presentation/view/widget/dialog.dart';
import '/base/presentation/base_view.dart';
import '/extension/extension.dart';
import '/features/shop/presentation/controller/product_provider.dart';

class SavePage extends BaseView {
  const SavePage({super.key});

  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    final controller = ref.read(savedViewProvider.notifier);

    controller.onInit(
      () async {
        await controller.upDateState();
      },
    );
    final state = ref.watch(savedViewProvider);
    final updateController = ref.read(updateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                await controller.deleteAllProduct();
                updateController.updateHome();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Remove All')
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: state.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CardTile(
                      product: state[index],
                      onSlide: (DismissDirection direction) {
                        controller.deleteProduct(state[index].id);
                        state.removeAt(index);
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });

                            return const CommonDialog(
                              title: 'Unsaved ',
                              icon: FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                              message: 'Remove From Save Success',
                            );
                          },
                        );
                        updateController.updateHome();
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
