import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_app/features/shop/data/model/remote_model/product_model.dart';

abstract class ProductApiRepo {
  Future<ProductList> getProduct();
}

class ProductApiImpl extends ProductApiRepo {
  // mock remote api should pick dio
  @override
  Future<ProductList> getProduct() async {
    final String resJson =
        await rootBundle.loadString('assets/json/json_mock_data.json');
    final response = ProductList.fromJson(jsonDecode(resJson));
    return response;
  }
}
