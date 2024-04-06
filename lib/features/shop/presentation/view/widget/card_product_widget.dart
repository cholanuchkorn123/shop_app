import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/features/shop/presentation/view/widget/dialog.dart';
import 'package:shop_app/main.dart';
import '/base/enums/enums.dart';
import '/base/presentation/base_view.dart';
import '/features/shop/domain/entities/product_entities.dart';
import '/features/shop/domain/usecase/add_product_usecase.dart';
import '/features/shop/domain/usecase/delete_product_usecase.dart';
import '/features/shop/presentation/controller/product_provider.dart';

class CardProduct extends BaseView {
  CardProduct(this.product, this.addProductUseCase, this.deleteProductUseCase,
      {super.key});
  final Product product;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  final ValueNotifier<bool> isLiked = ValueNotifier<bool>(false);

  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    isLiked.value = product.isSaved;
    final updateController = ref.read(updateProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'THB ${product.price}',
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: isLiked,
              builder: (__, ___, _) {
                return Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: isLiked.value ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        isLiked.value = !isLiked.value;
                        Future.delayed(const Duration(milliseconds: 200));
                        if (isLiked.value) {
                          await addProductUseCase.build(RequestUseCase(
                              input1: product, input2: DBtype.saved));
                        } else {
                          await deleteProductUseCase.build(RequestUseCase(
                              input1: product.id, input2: DBtype.saved));
                        }
                        showDialog(
                          context: navigatorKey.currentContext!,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });

                            return CommonDialog(
                              title: isLiked.value ? 'Saved ' : 'UnSaved',
                              icon: const FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                              message: isLiked.value
                                  ? 'Saved Success'
                                  : 'UnSaved Success',
                            );
                          },
                        );
                        updateController.updateHome();
                        updateController.updateSaved();
                      },
                    ));
              })
        ],
      ),
    );
  }
}
