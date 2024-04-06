import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/features/shop/domain/entities/product_entities.dart';
import '/features/shop/presentation/controller/cart_controller.dart';
import '/features/shop/presentation/controller/home_controller.dart';
import '/features/shop/presentation/controller/save_controller.dart';
import '/features/shop/presentation/controller/update_controller.dart';
import '/features/shop/presentation/controller/usecase_provider.dart';
import '../../data/data_source/remote/product_api.dart';
import '../../data/repo_impl/product_repoimpl.dart';
import '../../domain/repositories/shop_repo.dart';
import '/config/config_name.dart';
import '../../data/data_source/local/local_data_source.dart';
import '../../data/model/local_model/product_local_model.dart';
import '../../presentation/controller/tabbar_controller.dart';

final pageViewProvider =
    StateNotifierProvider.autoDispose<PageViewController, int>((ref) {
  return PageViewController();
});

final homeViewProvider =
    StateNotifierProvider<HomeController, List<Product>>((ref) {
  final getAllProductUseCase = ref.read(getAllProductProvider);
  final getMySaved = ref.read(getSaveProductProvider);
  return HomeController(getAllProductUseCase, getMySaved);
});
final cartViewProvider =
    StateNotifierProvider<CartController, List<Product>>((ref) {
  final deleteUseCase = ref.read(deleteProductProvider);
  final getMySaved = ref.read(getSaveProductProvider);
  final updateCartUseCase = ref.read(updateCartProductProvider);

  return CartController(getMySaved, deleteUseCase, updateCartUseCase);
});

final savedViewProvider =
    StateNotifierProvider<SaveController, List<Product>>((ref) {
  final getSaveProductUseCase = ref.read(getSaveProductProvider);
  final deleteUseCase = ref.read(deleteProductProvider);
  final deleteAllProductUseCase = ref.read(clearAllProductProvider);
  return SaveController(
      getSaveProductUseCase, deleteUseCase, deleteAllProductUseCase);
});

final productRepositoryProvider = Provider<ProductRepo>((ref) {
  final localDataSource = ref.read(productLocalDataSourceProvider);
  final remoteDataSource = ref.read(productRemoteDataSourceProvider);
  return ProductRepoImpl(remoteDataSource, localDataSource);
});

final productLocalDataSourceProvider = Provider.autoDispose<ShopLocalDB>((ref) {
  final Box<ProductModel> productBox = Hive.box(ConfigName.savedDbKey);
  final Box<ProductModel> cartBox = Hive.box(ConfigName.cartDbKey);

  return ShopLocalDB(productBox, cartBox);
});
final productRemoteDataSourceProvider =
    Provider.autoDispose<ProductApiRepo>((ref) {
  return ProductApiImpl();
});
final updateProvider = Provider.autoDispose<UpdateController>((ref) {
  final homeController = ref.read(homeViewProvider.notifier);
  final savedController = ref.read(savedViewProvider.notifier);
  final cartController = ref.read(cartViewProvider.notifier);
  return UpdateController(savedController, homeController, cartController);
});
