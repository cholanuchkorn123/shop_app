import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class GetAllProductUseCase extends BaseUseCase<void, List<Product>> {
  final ProductRepo _productRepo;
  GetAllProductUseCase(this._productRepo);
  @override
  Future<List<Product>> build(void input) async {
    return await _productRepo.getAllProduct();
  }
}
