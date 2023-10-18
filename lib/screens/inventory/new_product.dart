import 'package:mini_erp/widgets/divider_widget.dart';

import '../../constants.dart';
import '../../widgets/tax_table.dart';
import '/controllers/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProduct extends GetView<InventoryController> {
  const NewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: darkColor,
          onPressed: () {
            print(inventoryController.taxesValues.map((e) => e.taxPercentage));
            print(inventoryController.priceListValues.map((e) => e.price));
          },
          label: Row(
            children: [const Icon(Icons.add), Text('Save'.tr)],
          ),
        ),
        appBar: AppBar(
          backgroundColor: darkColor,
          title: Text('New Product'.tr),
          bottom: TabBar(
            indicatorColor: accentColor,
            isScrollable: true,
            tabs: [
              Tab(text: 'Product details'.tr),
              Tab(text: 'Product taxes'.tr),
              Tab(text: 'Product prices'.tr),
              // Tab(text: 'Product units'.tr),
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            productDetails(),
            taxListTab(),
            priceListTab(),
          ],
        ),
      ),
    );
  }
}

Widget productDetails() => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: inventoryController.newProductFormKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: TextStyle(color: darkColor),
              cursorColor: accentColor,
              controller: inventoryController.productName,
              decoration: InputDecoration(
                focusColor: darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(50)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'product name'.tr,
                labelStyle:
                    TextStyle(color: darkColor, fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value'.tr;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: accentColor,
              maxLines: 3,
              style: TextStyle(color: darkColor),
              controller: inventoryController.productDescription,
              decoration: InputDecoration(
                focusColor: darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(50)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'product description'.tr,
                labelStyle:
                    TextStyle(color: darkColor, fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value'.tr;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            buildDivider(),
            Text(
              "Opening Inventory".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              cursorColor: accentColor,
              style: TextStyle(color: darkColor),
              controller: inventoryController.productOpeningPrice,
              decoration: InputDecoration(
                focusColor: darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(50)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'average opening price'.tr,
                labelStyle:
                    TextStyle(color: darkColor, fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value'.tr;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              cursorColor: accentColor,
              style: TextStyle(color: darkColor),
              controller: inventoryController.productOpeningQuantity,
              decoration: InputDecoration(
                focusColor: darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(50)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'quantity'.tr,
                labelStyle:
                    TextStyle(color: darkColor, fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value'.tr;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              cursorColor: accentColor,
              style: TextStyle(color: darkColor),
              controller: inventoryController.productMinQuantity,
              decoration: InputDecoration(
                focusColor: darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(50)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'notify when quantity reach'.tr,
                labelStyle:
                    TextStyle(color: darkColor, fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value'.tr;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );

Widget taxListTab() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: inventoryController.taxesNamesList.isEmpty
                ? Center(
                    child: Container(
                    color: lightColor,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Please define taxes in Store management'.tr,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : buildTaxBatteryTable(),
          ),
        ),
      ],
    );

Widget priceListTab() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: inventoryController.priceListNamesList.isEmpty
                ? Center(
                    child: Container(
                    color: lightColor,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Please define price lists names in Store management'.tr,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : buildPriceListBatteryTable(),
          ),
        ),
      ],
    );
