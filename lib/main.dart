import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/config/binding.dart';
import 'package:shop_app/features/shop/data/model/local_model/product_local_model.dart';
import 'package:shop_app/features/shop/presentation/view/page/tabbar_page.dart';
import 'package:path_provider/path_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(ProductModelAdapter());
  await BindingInstanceApp.binding();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const TabBarPage(),
    );
  }
}
