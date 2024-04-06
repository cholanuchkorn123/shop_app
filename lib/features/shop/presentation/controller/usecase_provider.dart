import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/shop/presentation/controller/product_provider.dart';
import '../../domain/usecase/usecase.dart';

final getSaveProductProvider =
    Provider.autoDispose<GetSaveProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return GetSaveProductUseCase(repository);
});
final getAllProductProvider = Provider.autoDispose<GetAllProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return GetAllProductUseCase(repository);
});

final addProductProvider = Provider.autoDispose<AddProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return AddProductUseCase(repository);
});
final deleteProductProvider = Provider.autoDispose<DeleteProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return DeleteProductUseCase(repository);
});
final clearAllProductProvider =
    Provider.autoDispose<DeleteAllProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return DeleteAllProductUseCase(repository);
});
final updateCartProductProvider =
    Provider.autoDispose<UpdateCartUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return UpdateCartUseCase(repository);
});
