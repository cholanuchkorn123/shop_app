import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/data/model/local_model/product_local_model.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';

class ShopLocalDB {
  final Box<ProductModel> productBox;
  final Box<ProductModel> cartBox;

  ShopLocalDB(this.productBox, this.cartBox);

  List<Product> getListProduct(DBtype type) {
    if (type == DBtype.cart) {
      return cartBox.values.toList();
    } else if (type == DBtype.saved) {
      return productBox.values.toList();
    }
    return [];
  }

  Future<void> updateAmount(int id, DBtype type, UpdateType updateType) async {
    final items = getListProduct(type);

    if (items.isEmpty) {
      return;
    }

    final productIndex = items.indexWhere((product) => product.id == id);

    if (updateType == UpdateType.plus) {
      if (productIndex != -1) {
        final updatedProduct = items[productIndex]
            .copyWith(amount: items[productIndex].amount + 1);
        final ProductModel productModel =
            ProductModel.fromEntity(updatedProduct);
        await cartBox.putAt(productIndex, productModel);
      }
    } else if (updateType == UpdateType.minus) {
      if (items[productIndex].amount <= 1) {
        deleteProduct(items[productIndex].id, type);
        return;
      }
      final updatedProduct =
          items[productIndex].copyWith(amount: items[productIndex].amount - 1);
      final ProductModel productModel = ProductModel.fromEntity(updatedProduct);
      await cartBox.putAt(productIndex, productModel);
    }
  }

  void addProduct(ProductModel product, DBtype type) {
    if (type == DBtype.cart) {
      cartBox.add(product);
    } else if (type == DBtype.saved) {
      productBox.add(product);
    }
  }

  Future<void> deleteAll() async {
    await productBox.clear();
  }

  void deleteProduct(int index, DBtype type) {
    if (type == DBtype.saved) {
      final item = getListProduct(type);
      if (item.isEmpty) {
        return;
      }
      if (item.length == 1) {
        productBox.deleteAt(0);
        return;
      }

      for (var i = 0; i <= item.length - 1; i++) {
        if (item[i].id == index) {
          productBox.deleteAt(i);
        }
      }
    } else if (type == DBtype.cart) {
      final item = getListProduct(type);
      if (item.isEmpty) {
        return;
      }
      if (item.length == 1) {
        cartBox.deleteAt(0);
        return;
      }
      //[7,4,5] -- > 0:7
      for (var i = 0; i <= item.length - 1; i++) {
        if (item[i].id == index) {
          cartBox.deleteAt(i);
        }
      }
    }
  }
}
