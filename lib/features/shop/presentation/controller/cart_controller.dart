import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/usecase/updatecart_usecase.dart';
import 'package:shop_app/features/shop/domain/usecase/usecase.dart';

class CartController extends StateNotifier<List<Product>> {
  final GetSaveProductUseCase _getSaveProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  final UpdateCartUseCase _updateCartUseCase;
  CartController(this._getSaveProductUseCase, this._deleteProductUseCase,
      this._updateCartUseCase)
      : super(const []);

  Future<void> upDateState() async {
    state = await _getSaveProductUseCase.build(DBtype.cart);
  }

  Future<void> deleteProduct(int id) async {
    await _deleteProductUseCase
        .build(RequestUseCase(input1: id, input2: DBtype.cart));
    state = await _getSaveProductUseCase.build(DBtype.cart);
  }

  Future<void> plusCart(Product product) async {
    await _updateCartUseCase
        .build(RequestUseCase(input1: product, input2: UpdateType.plus));
    state = await _getSaveProductUseCase.build(DBtype.cart);
  }

  Future<void> minusCart(Product product) async {
    await _updateCartUseCase
        .build(RequestUseCase(input1: product, input2: UpdateType.minus));
    state = await _getSaveProductUseCase.build(DBtype.cart);
  }

  int priceTotal() {
    int sum = 0;

    sum = state.fold<int>(
        0,
        (previousValue, element) =>
            previousValue + element.amount * element.price);
    return sum;
  }
}
