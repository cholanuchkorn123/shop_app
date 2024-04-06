import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/base/enums/enums.dart';
import '/base/presentation/base_view.dart';
import '/features/shop/domain/entities/product_entities.dart';
import '/features/shop/domain/usecase/add_product_usecase.dart';
import '/features/shop/presentation/controller/product_provider.dart';
import '/features/shop/presentation/controller/usecase_provider.dart';
import '/main.dart';

class DetailPage extends BaseView {
  const DetailPage({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget myBuild(BuildContext context, WidgetRef ref) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    final addProductUseCase = ref.read(addProductProvider);
    final updateController = ref.read(updateProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: FaIcon(
                product.isSaved
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: product.isSaved ? Colors.red : Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
                side: const BorderSide(width: 2.0, color: Colors.black),
              ),
              onPressed: () async {
                await addProductUseCase.build(
                    RequestUseCase(input1: product, input2: DBtype.cart));
                updateController.updateCart();
                updateController.updateSaved();
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
