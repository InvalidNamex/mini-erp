import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/controllers/inventory_controller.dart';
import '/models/item_models/taxes_model.dart';
import '/constants.dart';

class NewTaxTile extends GetView<InventoryController> {
  const NewTaxTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          Get.back();
          Get.defaultDialog(
            title: 'New tax'.tr,
            content: Form(
              key: controller.addTaxFormKey,
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
                      hintText: 'Price tax name'.tr,
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
                    controller: controller.addTaxTextController,
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
                            if (controller.addTaxFormKey.currentState!
                                .validate()) {
                              List<TaxesModel> taxesNamesList =
                                  await dbController.readTaxesNames();
                              List taxesName = [];
                              for (var element in taxesNamesList) {
                                taxesName.add(element.taxName);
                              }
                              if (!taxesName.contains(
                                  controller.addTaxTextController.text)) {
                                await dbController.addTax(TaxesModel(
                                    taxName:
                                        controller.addTaxTextController.text));
                                controller.taxesNamesList.value =
                                    await dbController.readTaxesNames();
                                controller.addTaxTextController.clear();
                                Get.back();
                              } else {
                                controller.addTaxTextController.clear();
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
          );
        },
        leading: Icon(
          Icons.add,
          size: 30,
          color: darkColor,
        ),
        title: Text('New tax'.tr,
            style: TextStyle(
              color: darkColor,
            )),
      ),
    );
  }
}
