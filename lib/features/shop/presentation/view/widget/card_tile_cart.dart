import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/features/shop/domain/entities/product_entities.dart';

class CartTileCart extends StatelessWidget {
  const CartTileCart({
    super.key,
    required this.product,
    required this.onSlide,
    required this.minusCallback,
    required this.plusCallback,
  });

  final Product product;
  final void Function(DismissDirection) onSlide;
  final VoidCallback minusCallback;

  final VoidCallback plusCallback;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Dismissible(
      key: Key(product.id.toString()),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: FaIcon(
            FontAwesomeIcons.trash,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: onSlide,
      child: ListTile(
          leading: SizedBox(
            width: 60,
            height: 60,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 1.0, color: Colors.black),
            ),
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: minusCallback,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.minus,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  ' ${product.amount}',
                  style: const TextStyle(fontSize: 20),
                ),
                GestureDetector(
                  onTap: plusCallback,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
