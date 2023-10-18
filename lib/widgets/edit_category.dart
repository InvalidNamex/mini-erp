import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import '../constants.dart';
import '../models/item_models/category_model.dart';

class EditCategory extends GetView<InventoryController> {
  final int id;
  const EditCategory({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async => Get.defaultDialog(
              title: 'Edit classification'.tr,
              content: Form(
                key: controller.editClassificationFormKey,
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
                        hintText: 'Classification name'.tr,
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
                      controller: controller.editClassificationTextController,
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
                              if (controller
                                  .editClassificationFormKey.currentState!
                                  .validate()) {
                                List<CategoryModel> categories =
                                    await dbController.readCategories();
                                List categoryNames = [];
                                for (var element in categories) {
                                  categoryNames.add(element.categoryName);
                                }
                                if (!categoryNames.contains(controller
                                    .editClassificationTextController.text)) {
                                  dbController.updateCategory(
                                      id,
                                      controller
                                          .editClassificationTextController
                                          .text);
                                  controller.categoryList.value =
                                      await dbController.readCategories();
                                  controller.editClassificationTextController
                                      .clear();
                                  Get.back();
                                } else {
                                  controller.editClassificationTextController
                                      .clear();
                                  Get.back();
                                  Get.snackbar('Repetitive Name'.tr,
                                      'Classification name already exists'.tr,
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
