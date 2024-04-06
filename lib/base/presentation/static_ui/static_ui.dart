import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/features/shop/presentation/view/page/cart_page.dart';
import '/features/shop/presentation/view/page/home_page.dart';
import '/features/shop/presentation/view/page/save_page.dart';

class StaticUI {
  static const List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.house,
          color: Colors.grey,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.solidHeart,
          color: Colors.grey,
        ),
        label: 'Save'),
    BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.cartShopping,
          color: Colors.grey,
        ),
        label: 'Cart'),
  ];
  static const List<Widget> listPage = [HomePage(), SavePage(), CartPage()];
}
