import 'package:get/get.dart';
import 'package:mini_erp/controllers/db_controller.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import '/localization_hierarchy/localization_controller.dart';

import 'controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(LocalizationController());
    Get.put(DatabaseController(), permanent: true);
  }
}

class InventoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InventoryController());
  }
}
