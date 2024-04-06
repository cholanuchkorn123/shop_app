// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      urlImage: json['image_url'] as String,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'isSaved': instance.isSaved,
      'amount': instance.amount,
      'image_url': instance.urlImage,
    };

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
      productItems: (json['product_items'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'product_items': instance.productItems,
    };
