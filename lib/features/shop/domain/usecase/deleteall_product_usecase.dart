import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class DeleteAllProductUseCase extends BaseUseCase<void, void> {
  final ProductRepo _productRepo;
  DeleteAllProductUseCase(this._productRepo);

  @override
  Future<void> build(void input) async {
    await _productRepo.clearAllSavedProduct();
  }
}
