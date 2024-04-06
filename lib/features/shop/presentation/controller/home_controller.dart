import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/base/enums/enums.dart';
import 'package:shop_app/features/shop/domain/entities/product_entities.dart';
import 'package:shop_app/features/shop/domain/usecase/get_save_product_usecase.dart';
import 'package:shop_app/features/shop/domain/usecase/getall_product_usecase.dart';

class HomeController extends StateNotifier<List<Product>> {
  final GetAllProductUseCase _allProductUseCase;
  final GetSaveProductUseCase _getSaveProductUseCase;
  HomeController(this._allProductUseCase, this._getSaveProductUseCase)
      : super(const []);

  Future<void> upDateState() async {
    final itemAll = await _allProductUseCase.build(null);
    final itemSaved = await _getSaveProductUseCase.build(DBtype.saved);
    final savedItemIds = itemSaved.map((item) => item.id).toSet();

    for (var item in itemAll) {
      if (savedItemIds.contains(item.id)) {
        item.isSaved = true;
      }
    }
    state = itemAll;
  }
}
