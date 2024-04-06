import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';
import 'package:shop_app/features/shop/domain/usecase/add_product_usecase.dart';

class DeleteProductUseCase
    extends BaseUseCase<RequestUseCase<int, DBtype>, void> {
  final ProductRepo _productRepo;
  DeleteProductUseCase(this._productRepo);

  @override
  Future<void> build(RequestUseCase input) async {
    await _productRepo.deleteProduct(input.input1, input.input2);
  }
}
