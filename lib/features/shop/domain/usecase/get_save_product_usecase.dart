import 'package:shop_app/base/domain/usecase_base.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/repositories/shop_repo.dart';

class GetSaveProductUseCase extends BaseUseCase<DBtype, List<Product>> {
  final ProductRepo _productRepo;
  GetSaveProductUseCase(this._productRepo);
  @override
  Future<List<Product>> build(DBtype input) async {
    return await _productRepo.getDBproduct(input);
  }
}
