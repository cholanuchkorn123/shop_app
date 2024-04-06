import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/features/shop/presentation/view/widget/card_tile_cart.dart';
import '/features/shop/presentation/view/widget/dialog.dart';
import '/features/shop/presentation/view/widget/qr_image.dart';
import '/base/presentation/base_view.dart';
import '/extension/extension.dart';
import '/features/shop/presentation/controller/product_provider.dart';

class CartPage extends BaseView {
  const CartPage({super.key});

  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartViewProvider.notifier);

    controller.onInit(
      () async {
        await controller.upDateState();
      },
    );
    final state = ref.watch(cartViewProvider);
    final updateController = ref.read(updateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: Padding(
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
                child: CartTileCart(
                  plusCallback: () async {
                    await controller.plusCart(state[index]);
                    updateController.updateSaved();
                  },
                  minusCallback: () async {
                    await controller.minusCart(state[index]);
                    updateController.updateSaved();
                  },
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
                          title: 'Delete from Cart ',
                          icon: FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                          message: 'Remove From Cart Success',
                        );
                      },
                    );
                  },
                ),
              );
            }),
      ),
      bottomNavigationBar: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ${controller.priceTotal()}',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    side: const BorderSide(width: 2.0, color: Colors.black),
                  ),
                  onPressed: () {
                    if (controller.priceTotal() > 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  QRImage(controller.priceTotal().toString())));
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                          });

                          return const CommonDialog(
                            title: 'Cart is Empty ',
                            icon: FaIcon(
                              FontAwesomeIcons.x,
                              color: Colors.white,
                              size: 30,
                            ),
                            errorDialog: true,
                            message: 'PLease Add Product to Your Cart',
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    'CheckOut',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
