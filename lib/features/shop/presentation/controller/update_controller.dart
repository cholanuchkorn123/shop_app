import 'package:shop_app/features/shop/presentation/controller/cart_controller.dart';
import 'package:shop_app/features/shop/presentation/controller/home_controller.dart';
import 'package:shop_app/features/shop/presentation/controller/save_controller.dart';

class UpdateController {
  final SaveController _saveController;
  final HomeController _homeController;
  final CartController _cartController;
  UpdateController(
      this._saveController, this._homeController, this._cartController);

  updateHome() {
    _homeController.upDateState();
  }

  updateSaved() {
    _saveController.upDateState();
  }

  updateCart() {
    _cartController.upDateState();
  }
}
