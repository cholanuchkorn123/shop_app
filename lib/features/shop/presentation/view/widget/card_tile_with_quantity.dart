import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/features/shop/domain/entities/product_entities.dart';

class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.product, required this.onSlide});

  final Product product;
  final void Function(DismissDirection) onSlide;
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
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Text(product.amount.toString())),
          )),
    );
  }
}
