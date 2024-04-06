import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/data/data_source/local/local_data_source.dart';
import 'package:shop_app/features/shop/data/data_source/remote/product_api.dart';
import 'package:shop_app/features/shop/data/model/local_model/product_local_model.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductApiRepo _productApiRepo;
  final ShopLocalDB _shopLocalDB;
  ProductRepoImpl(this._productApiRepo, this._shopLocalDB);
  @override
  Future<void> deleteProduct(int index, DBtype type) async {
    _shopLocalDB.deleteProduct(index, type);
  }

  @override
  Future<List<Product>> getAllProduct() async {
    final res = await _productApiRepo.getProduct();
    return res.productItems;
  }

  @override
  Future<void> saveProduct(Product product, DBtype type) async {
    if (type == DBtype.saved) {
      final productConvert = ProductModel.fromEntity(product);
      final myProduct = await getDBproduct(type);
      if (myProduct.any((p) => p.id == productConvert.id)) {
        return;
      }

      _shopLocalDB.addProduct(productConvert, type);
    } else if (type == DBtype.cart) {
      product.amount = 1;
      final productConvert = ProductModel.fromEntity(product);

      final myProduct = await getDBproduct(type);

      if (myProduct.any((p) => p.id == productConvert.id)) {
        await _shopLocalDB.updateAmount(
            productConvert.id, type, UpdateType.plus);
        return;
      }

      _shopLocalDB.addProduct(productConvert, type);
    }
  }

  @override
  Future<List<Product>> getDBproduct(DBtype type) async {
    final res = _shopLocalDB.getListProduct(type);
    final resCart = _shopLocalDB.getListProduct(DBtype.cart);
    final cartMap = {
      for (var cartProduct in resCart) cartProduct.id: cartProduct
    };
    // should change db to one box only and saved field
    for (var item in res) {
      final cartProduct = cartMap[item.id];
      if (cartProduct != null) {
        item.amount = cartProduct.amount;
      }
    }

    return res;
  }

  @override
  Future<void> clearAllSavedProduct() async {
    await _shopLocalDB.deleteAll();
  }

  @override
  Future<void> updateCart(UpdateType type, Product product) async {
    if (type == UpdateType.plus) {
      final productConvert = ProductModel.fromEntity(product);
      productConvert.amount = 1;
      final myProduct = await getDBproduct(DBtype.cart);

      if (myProduct.any((p) => p.id == productConvert.id)) {
        await _shopLocalDB.updateAmount(
            productConvert.id, DBtype.cart, UpdateType.plus);
        return;
      }
    } else if (type == UpdateType.minus) {
      final productConvert = ProductModel.fromEntity(product);

      final myProduct = await getDBproduct(DBtype.cart);

      if (myProduct.any((p) => p.id == productConvert.id)) {
        await _shopLocalDB.updateAmount(
            productConvert.id, DBtype.cart, UpdateType.minus);
        return;
      }
    }
  }
}
