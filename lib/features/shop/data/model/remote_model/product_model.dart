import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductItem extends Product {
  @JsonKey(name: 'image_url')
  final String urlImage;

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  ProductItem(
      {required super.id,
      required super.name,
      required super.price,
      required this.urlImage})
      : super(imageUrl: urlImage);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class ProductList {
  @JsonKey(name: 'product_items')
  final List<ProductItem> productItems;

  ProductList({required this.productItems});

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}
