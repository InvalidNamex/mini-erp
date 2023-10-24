import 'package:dropdown_search/dropdown_search.dart';
import 'package:mini_erp/widgets/divider_widget.dart';
import '../../constants.dart';
import '../../widgets/tax_table.dart';
import '/controllers/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProduct extends StatelessWidget {
  NewProduct({super.key});
  final InventoryController controller = Get.find<InventoryController>();
  @override
  Widget build(BuildContext context) {
    controller.populateCategoryList();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: darkColor,
          onPressed: () {
            print(controller.taxesValues.map((e) => e.taxPercentage));
            print(controller.priceListValues.map((e) => e.price));
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

  Widget taxListTab() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Expanded(
              child: controller.taxesNamesList.isEmpty
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
              child: controller.priceListNamesList.isEmpty
                  ? Center(
                      child: Container(
                      color: lightColor,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Please define price lists names in Store management'
                            .tr,
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
  Widget productDetails() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: controller.newProductFormKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 7,
            ),
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: controller.categoryNamesList,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  focusColor: darkColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Categories'.tr,
                  hintText: "choose a category".tr,
                  labelStyle: TextStyle(color: darkColor),
                ),
              ),
              onChanged: print,
              selectedItem: controller.categoryNamesList[0],
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: TextStyle(color: darkColor),
              cursorColor: accentColor,
              controller: controller.productName,
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
              controller: controller.productDescription,
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
              controller: controller.productOpeningPrice,
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
              controller: controller.productOpeningQuantity,
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
              controller: controller.productMinQuantity,
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
  }
}
