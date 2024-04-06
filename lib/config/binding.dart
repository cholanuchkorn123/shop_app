import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/config/config_name.dart';
import 'package:shop_app/features/shop/data/model/local_model/product_local_model.dart';

class BindingInstanceApp {
  final locator = GetIt.I;
  static Future<void> binding() async {
    await Hive.openBox<ProductModel>(ConfigName.savedDbKey);
    await Hive.openBox<ProductModel>(ConfigName.cartDbKey);
  }
}
