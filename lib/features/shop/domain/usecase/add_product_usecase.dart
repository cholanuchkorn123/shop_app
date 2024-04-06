import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class AddProductUseCase
    extends BaseUseCase<RequestUseCase<Product, DBtype>, void> {
  final ProductRepo _productRepo;
  AddProductUseCase(this._productRepo);
  @override
  Future<void> build(RequestUseCase input) async {
    await _productRepo.saveProduct(input.input1, input.input2);
  }
}

class RequestUseCase<T, W> {
  final T input1;
  final W input2;

  RequestUseCase({required this.input1, required this.input2});
}
