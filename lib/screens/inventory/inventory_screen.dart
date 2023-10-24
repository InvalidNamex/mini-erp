import 'package:get/get.dart';
import 'package:mini_erp/widgets/edit_price_list.dart';
import 'package:mini_erp/widgets/new_tax_tile.dart';
import '../../constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/edit_category.dart';
import '../../widgets/edit_tax.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/new_category_tile.dart';
import '../../widgets/new_price_list_tile.dart';
import '../../widgets/vertical_divider.dart';
import '/controllers/inventory_controller.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: darkColor,
          child: ListView(
            children: const [
              NewCategory(),
              NewPriceList(),
              NewTaxTile(),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: darkColor,
          title: Text('Inventory Management'.tr),
          bottom: TabBar(
            indicatorColor: accentColor,
            isScrollable: true,
            tabs: [
              Tab(text: 'Products'.tr),
              Tab(text: 'Categories'.tr),
              Tab(text: 'Price lists'.tr),
              Tab(text: 'Taxes'.tr),
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  // opacity: 0.9,
                  image: AssetImage('assets/bg.jpeg'),
                  fit: BoxFit.fill)),
          child: TabBarView(
            children: [
              ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                children: [
                  CustomCard(
                    icon: Icons.add,
                    title: 'New product',
                    myFunc: () => Get.toNamed('/new-product'),
                  ),
                  CustomCard(
                    icon: Icons.list_alt,
                    title: 'Display products',
                    myFunc: () => Get.toNamed('/'),
                  ),
                  CustomCard(
                    icon: Icons.list_alt,
                    title: 'Edit products',
                    myFunc: () => Get.toNamed('/'),
                  ),
                  buildDivider(),
                  CustomCard(
                    image: 'assets/excel.webp',
                    title: 'Import products from Excel file',
                    myFunc: () => Get.toNamed('/'),
                  ),
                ],
              ),
              const CategoryTab(),
              const PriceListTab(),
              const TaxListTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTab extends GetView<InventoryController> {
  const CategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: controller.categoryList.isEmpty
                ? Center(
                    child: Container(
                    color: lightColor,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'categories are empty'.tr,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GlassContainer(
                        child: ListTile(
                          title: Text(
                            controller.categoryList[index].categoryName!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: lightColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CustomVerticalDivider(),
                              EditCategory(
                                  id: controller
                                      .categoryList[index].categoryID!),
                              const CustomVerticalDivider(),
                              IconButton(
                                  onPressed: () async {
                                    //TODO: check if there are items linked to this category
                                    await dbController.deleteCategory(controller
                                        .categoryList[index].categoryID!);
                                    controller.categoryList.value =
                                        await dbController.readCategories();
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red.shade800,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      itemCount: controller.categoryList.length,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class PriceListTab extends GetView<InventoryController> {
  const PriceListTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      'Price lists are empty'.tr,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GlassContainer(
                        child: ListTile(
                          title: Text(
                            controller.priceListNamesList[index].priceListName!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: lightColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CustomVerticalDivider(),
                              EditPriceList(
                                  id: controller
                                      .priceListNamesList[index].priceListID!),
                              const CustomVerticalDivider(),
                              IconButton(
                                  onPressed: () async {
                                    //TODO: check if there are items linked to this price list
                                    await dbController.deletePriceList(
                                        controller.priceListNamesList[index]
                                            .priceListID!);
                                    controller.priceListNamesList.value =
                                        await dbController.readPriceLists();
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red.shade800,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      itemCount: controller.priceListNamesList.length,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class TaxListTab extends GetView<InventoryController> {
  const TaxListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      'No taxes defined'.tr,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GlassContainer(
                        child: ListTile(
                          title: Text(
                            controller.taxesNamesList[index].taxName!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: lightColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CustomVerticalDivider(),
                              EditTax(
                                  id: controller.taxesNamesList[index].taxID!),
                              const CustomVerticalDivider(),
                              IconButton(
                                  onPressed: () async {
                                    //TODO: check if there are items linked to this tax list
                                    await dbController.deleteTax(controller
                                        .taxesNamesList[index].taxID!);
                                    controller.taxesNamesList.value =
                                        await dbController.readTaxesNames();
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red.shade800,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      itemCount: controller.taxesNamesList.length,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
