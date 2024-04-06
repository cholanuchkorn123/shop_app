import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';
import 'package:shop_app/features/shop/domain/usecase/add_product_usecase.dart';

class UpdateCartUseCase
    extends BaseUseCase<RequestUseCase<Product, UpdateType>, void> {
  final ProductRepo _productRepo;
  UpdateCartUseCase(this._productRepo);

  @override
  Future<void> build(RequestUseCase<Product, UpdateType> input) async {
    await _productRepo.updateCart(input.input2, input.input1);
  }
}
