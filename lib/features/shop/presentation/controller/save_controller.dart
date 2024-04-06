import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/usecase/deleteall_product_usecase.dart';
import 'package:shop_app/features/shop/domain/usecase/usecase.dart';

class SaveController extends StateNotifier<List<Product>> {
  final GetSaveProductUseCase _getSaveProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final DeleteAllProductUseCase _deleteAllProduct;

  SaveController(this._getSaveProductUseCase, this._deleteProductUseCase,
      this._deleteAllProduct)
      : super(const []);

  Future<void> upDateState() async {
    state = await _getSaveProductUseCase.build(DBtype.saved);
  }

  Future<void> deleteProduct(int id) async {
    await _deleteProductUseCase
        .build(RequestUseCase(input1: id, input2: DBtype.saved));
    state = await _getSaveProductUseCase.build(DBtype.saved);
  }

  Future<void> deleteAllProduct() async {
    await _deleteAllProduct.build(null);
    state = await _getSaveProductUseCase.build(DBtype.saved);
  }
}
