import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_erp/screens/inventory/new_product.dart';
import '/screens/inventory/inventory_screen.dart';
import '/screens/sales/sales_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '/screens/home_screen.dart';
import 'bindings.dart';
import 'constants.dart';
import 'localization_hierarchy/languages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: Languages(),
      title: 'Mini-ERP',
      initialRoute: '/',
      enableLog: true,
      logWriterCallback: (text, {isError = false}) {
        if (isError) {
          Get.defaultDialog(
              backgroundColor: darkColor,
              titleStyle: TextStyle(color: accentColor),
              title: 'Error',
              content: Text(
                text,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: lightColor),
              ));
        } else {}
      },
      fallbackLocale: const Locale('en', 'US'),
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(
            name: '/',
            page: () => const HomeScreen(),
            binding: HomeBinding(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/sales',
            page: () => const SalesScreen(),
            binding: HomeBinding(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/inventory',
            page: () => const InventoryScreen(),
            binding: InventoryBinding(),
            transition: Transition.downToUp,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/new-product',
            page: () => NewProduct(),
            binding: InventoryBinding(),
            transition: Transition.upToDown,
            transitionDuration: const Duration(milliseconds: 300)),
      ],
    );
  }
}
