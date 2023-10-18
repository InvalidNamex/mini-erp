import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  TextEditingController salesSearchBox = TextEditingController();
  List<String> x = [
    'Sales',
    'Purchases',
    'Clients',
    'Vendors',
    'Cash',
    'Expenses',
    'Inventory',
    'Reports',
  ];
}
