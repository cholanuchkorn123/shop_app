import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/features/shop/data/data_source/remote/product_api.dart';
import 'package:shop_app/features/shop/data/model/remote_model/product_model.dart';

class MockApiRepo extends Mock implements ProductApiRepo {}

void main() {
  late ProductApiRepo productApi;

  setUp(() {
    productApi = MockApiRepo();
  });

  test('product all should fetch', () async {
    const mockJson = '''
    {
      "product_items": [
        {
          "id": 1,
          "name": "T-Bone Slice 300g.",
          "image_url": "https://images.unsplash.com/photo-1551028150-64b9f398f678?fit=crop&w=200&q=200",
          "price": 250
        },
        {
          "id": 2,
          "name": "Eggs No.1 Pack 30",
          "image_url": "https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?fit=crop&w=200&q=200",
          "price": 149
        }
      ]
    }
    ''';

    when(() => productApi.getProduct()).thenAnswer((_) async {
      final productList = ProductList.fromJson(jsonDecode(mockJson));
      return productList;
    });

    final returnedProductList = await productApi.getProduct();

    expect(returnedProductList, isA<ProductList>());

    expect(returnedProductList.productItems.length, 2);
  });
}
