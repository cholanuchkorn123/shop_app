import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';

part 'product_local_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imgUrl;

  @HiveField(3)
  final int price;

  @HiveField(4)
  int? amountItem;

  ProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.price,
      required this.amountItem})
      : super(
            id: id,
            name: name,
            imageUrl: imgUrl,
            price: price,
            amount: amountItem ?? 0);
  factory ProductModel.fromEntity(Product product) => ProductModel(
      id: product.id,
      name: product.name,
      imgUrl: product.imageUrl,
      price: product.price,
      amountItem: product.amount);
  Product toEntity() => Product(
      id: id, name: name, imageUrl: imgUrl, price: price, amount: amount ?? 0);
}
