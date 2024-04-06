import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/data/model/local_model/product_local_model.dart';
import 'package:shop_app/features/shop/data/data_source/local/local_data_source.dart';

class MockShopLocalDB extends Mock implements ShopLocalDB {}

void main() {
  late ShopLocalDB shopLocalDB;

  setUp(() {
    shopLocalDB = MockShopLocalDB();
  });

  test('getListProduct should return products from the correct box', () {
    final savedProducts = [
      ProductModel(
          id: 1, name: 'Product 1', imgUrl: '', price: 10, amountItem: 1),
      ProductModel(
          id: 1, name: 'Product 2', imgUrl: '', price: 20, amountItem: 2)
    ];

    final cartProducts = [
      ProductModel(
          id: 3, name: 'Product 3', imgUrl: '', price: 30, amountItem: 3),
      ProductModel(
          id: 4, name: 'Product 4', imgUrl: '', price: 40, amountItem: 4),
    ];

    when(() => shopLocalDB.getListProduct(DBtype.saved))
        .thenReturn(savedProducts);
    when(() => shopLocalDB.getListProduct(DBtype.cart))
        .thenReturn(cartProducts);

    expect(shopLocalDB.getListProduct(DBtype.saved), savedProducts);
    expect(shopLocalDB.getListProduct(DBtype.cart), cartProducts);
  });

  test('updateAmount should update product amount in the cart', () async {
    final cartProducts = [
      ProductModel(
          id: 5, name: 'Product 5', imgUrl: '', price: 10, amountItem: 1),
    ];

    when(() => shopLocalDB.getListProduct(DBtype.cart))
        .thenReturn(cartProducts);

    when(() => shopLocalDB.updateAmount(any(), DBtype.cart, UpdateType.plus))
        .thenAnswer((invocation) async {
      cartProducts[0].amountItem = cartProducts[0].amountItem! + 1;
    });

    await shopLocalDB.updateAmount(
        cartProducts[0].id, DBtype.cart, UpdateType.plus);

    final updatedProduct =
        cartProducts.firstWhere((product) => product.id == cartProducts[0].id);
    expect(updatedProduct.amountItem, 2);
  });

  test('addProduct should add product to the correct box', () {
    final productToAdd = ProductModel(
        id: 1, name: 'Product 1', imgUrl: '', price: 10, amountItem: 1);
    when(() => shopLocalDB.addProduct(productToAdd, DBtype.saved))
        .thenAnswer((_) async {});

    shopLocalDB.addProduct(productToAdd, DBtype.saved);

    verify(() => shopLocalDB.addProduct(productToAdd, DBtype.saved)).called(1);
  });

  test('deleteAll should clear the product box', () async {
    when(() => shopLocalDB.deleteAll()).thenAnswer((_) async {});

    await shopLocalDB.deleteAll();

    verify(() => shopLocalDB.deleteAll()).called(1);
  });

  test('deleteProduct should delete the product from the correct box', () {
    final productToDelete = ProductModel(
        id: 1, name: 'Product 1', imgUrl: '', price: 10, amountItem: 1);

    when(() => shopLocalDB.getListProduct(DBtype.saved))
        .thenReturn([productToDelete]);

    shopLocalDB.deleteProduct(1, DBtype.saved);

    verify(() => shopLocalDB.deleteProduct(1, DBtype.saved)).called(1);
  });
}
