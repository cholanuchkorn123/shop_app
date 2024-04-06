import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';

abstract class ProductRepo {
  Future<List<Product>> getAllProduct();
  Future<void> deleteProduct(int index, DBtype type);
  Future<void> saveProduct(Product product, DBtype type);
  Future<List<Product>> getDBproduct(DBtype type);
  Future<void> clearAllSavedProduct();
  Future<void> updateCart(UpdateType type, Product product);
}
