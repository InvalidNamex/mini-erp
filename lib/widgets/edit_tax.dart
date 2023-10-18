import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import '../constants.dart';
import '../models/item_models/taxes_model.dart';

class EditTax extends GetView<InventoryController> {
  final int id;
  const EditTax({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async => Get.defaultDialog(
              title: 'Edit Tax'.tr,
              content: Form(
                key: controller.editTaxFormKey,
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
                        hintText: 'Tax name'.tr,
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
                      controller: controller.editTaxTextController,
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
                              if (controller.editTaxFormKey.currentState!
                                  .validate()) {
                                List<TaxesModel> taxes =
                                    await dbController.readTaxesNames();
                                List taxesNames = [];
                                for (var element in taxes) {
                                  taxesNames.add(element.taxName);
                                }
                                if (!taxesNames.contains(
                                    controller.editTaxTextController.text)) {
                                  dbController.updateTax(id,
                                      controller.editTaxTextController.text);
                                  controller.taxesNamesList.value =
                                      await dbController.readTaxesNames();
                                  controller.editTaxTextController.clear();
                                  Get.back();
                                } else {
                                  controller.editTaxTextController.clear();
                                  Get.back();
                                  Get.snackbar('Repetitive Name'.tr,
                                      'Tax name already exists'.tr,
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
