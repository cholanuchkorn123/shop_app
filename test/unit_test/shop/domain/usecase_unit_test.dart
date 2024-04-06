import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class MockProductRepo extends Mock implements ProductRepo {}

void main() {
  late MockProductRepo mockRepo;

  setUp(() {
    mockRepo = MockProductRepo();
  });

  test('add product usecase should add ', () async {
    final product = Product(id: 1, name: 'Product 1', imageUrl: '', price: 400);
    when(() => mockRepo.saveProduct(product, DBtype.saved))
        .thenAnswer((_) async {});
    await mockRepo.saveProduct(product, DBtype.saved);
    verify(() => mockRepo.saveProduct(product, DBtype.saved)).called(1);
  });
  test('getCart product usecase should return Productlist ', () async {
    final List<Product> productList = [
      Product(id: 1, name: 'Product 1', imageUrl: '', price: 400)
    ];
    when(() => mockRepo.getDBproduct(DBtype.cart)).thenAnswer((_) async {
      return Future.value(productList);
    });
    final res = await mockRepo.getDBproduct(DBtype.cart);
    expect(res, productList);
    verify(() => mockRepo.getDBproduct(DBtype.cart)).called(1);
  });
  test('delete product usecase should delete ', () async {
    final product = Product(id: 1, name: 'Product 1', imageUrl: '', price: 400);
    when(() => mockRepo.deleteProduct(product.id, DBtype.saved))
        .thenAnswer((_) async {});
    await mockRepo.deleteProduct(product.id, DBtype.saved);
    verify(() => mockRepo.deleteProduct(product.id, DBtype.saved)).called(1);
  });
  test('deleteAll product usecase should delete ', () async {
    when(() => mockRepo.clearAllSavedProduct()).thenAnswer((_) async {});
    await mockRepo.clearAllSavedProduct();
    verify(() => mockRepo.clearAllSavedProduct()).called(1);
  });
  test('getSave product usecase should return Productlist ', () async {
    final List<Product> productList = [
      Product(id: 1, name: 'Product 1', imageUrl: '', price: 400)
    ];
    when(() => mockRepo.getDBproduct(DBtype.saved)).thenAnswer((_) async {
      return Future.value(productList);
    });
    final res = await mockRepo.getDBproduct(DBtype.saved);
    expect(res, productList);
    verify(() => mockRepo.getDBproduct(DBtype.saved)).called(1);
  });
  test('getAll product usecase should return Productlist ', () async {
    final List<Product> productList = [
      Product(id: 1, name: 'Product 1', imageUrl: '', price: 400)
    ];
    when(() => mockRepo.getAllProduct()).thenAnswer((_) async {
      return Future.value(productList);
    });
    final res = await mockRepo.getAllProduct();
    expect(res, productList);
    verify(() => mockRepo.getAllProduct()).called(1);
  });
  test('updateCart product usecase should update ', () async {
    final product =
        Product(id: 1, name: 'Product 1', imageUrl: '', price: 400, amount: 1);
    when(() => mockRepo.updateCart(UpdateType.plus, product))
        .thenAnswer((_) async {
      product.amount++;
    });
    await mockRepo.updateCart(UpdateType.plus, product);

    expect(product.amount, 2);
    verify(() => mockRepo.updateCart(UpdateType.plus, product)).called(1);
  });
}
