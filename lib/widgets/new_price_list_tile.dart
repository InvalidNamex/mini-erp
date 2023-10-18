import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import 'package:mini_erp/models/item_models/price_list_model.dart';
import '/constants.dart';

class NewPriceList extends GetView<InventoryController> {
  const NewPriceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          Get.back();
          Get.defaultDialog(
            title: 'New price list'.tr,
            content: Form(
              key: controller.addPriceListFormKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value'.tr; // Validation message
                      }
                      return null; // Return null if the input is valid
                    },
                    decoration: InputDecoration(
                      hintText: 'Price list name'.tr,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .transparent), // Change the border color when focused
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.withOpacity(
                                0.5)), // Change the border color when not focused
                      ),
                    ),
                    cursorColor: darkColor, // Change the cursor color
                    autofocus: true,
                    controller: controller.addPriceListTextController,
                  ),
                  SizedBox(
                      width: double
                          .infinity, // Set the container's width to maximum
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                darkColor), // Set the button's background color
                          ),
                          onPressed: () async {
                            if (controller.addPriceListFormKey.currentState!
                                .validate()) {
                              List<PriceListModel> priceLists =
                                  await dbController.readPriceLists();
                              List priceListNames = [];
                              for (var element in priceLists) {
                                priceListNames.add(element.priceListName);
                              }
                              if (!priceListNames.contains(
                                  controller.addPriceListTextController.text)) {
                                await dbController.addPriceList(PriceListModel(
                                    priceListName: controller
                                        .addPriceListTextController.text));
                                controller.priceListNamesList.value =
                                    await dbController.readPriceLists();
                                controller.addPriceListTextController.clear();
                                Get.back();
                              } else {
                                controller.addPriceListTextController.clear();
                                Get.back();
                                Get.snackbar('Repetitive Name'.tr,
                                    'Price list name already exists'.tr,
                                    backgroundColor: accentColor);
                              }
                            }
                          },
                          child: Text('Save'.tr)))
                ],
              ),
            ),
          );
        },
        leading: Icon(
          Icons.add,
          size: 30,
          color: darkColor,
        ),
        title: Text('New price list'.tr,
            style: TextStyle(
              color: darkColor,
            )),
      ),
    );
  }
}
