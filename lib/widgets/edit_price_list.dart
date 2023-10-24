import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import 'package:mini_erp/models/item_models/price_list_model.dart';
import '../constants.dart';

class EditPriceList extends GetView<InventoryController> {
  final int id;
  const EditPriceList({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async => Get.defaultDialog(
              title: 'Edit price list'.tr,
              content: Form(
                key: controller.editCategoryFormKey,
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
                      cursorColor: Colors.green, // Change the cursor color
                      autofocus: true,
                      controller: controller.editPriceListTextController,
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
                              if (controller.editCategoryFormKey.currentState!
                                  .validate()) {
                                List<PriceListModel> priceLists =
                                    await dbController.readPriceLists();
                                List priceListNames = [];
                                for (var element in priceLists) {
                                  priceListNames.add(element.priceListName);
                                }
                                if (!priceListNames.contains(controller
                                    .editCategoryTextController.text)) {
                                  dbController.updatePriceList(
                                      id,
                                      controller
                                          .editPriceListTextController.text);
                                  controller.priceListNamesList.value =
                                      await dbController.readPriceLists();
                                  controller.editPriceListTextController
                                      .clear();
                                  Get.back();
                                } else {
                                  controller.editPriceListTextController
                                      .clear();
                                  Get.back();
                                  Get.snackbar('Repetitive Name'.tr,
                                      'Category name already exists'.tr,
                                      backgroundColor: accentColor);
                                }
                              }
                            },
                            child: Text('Save'.tr)))
                  ],
                ),
              ),
            ),
        icon: Icon(
          Icons.edit,
          color: darkColor,
        ));
  }
}
