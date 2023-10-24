import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_erp/controllers/inventory_controller.dart';
import '../models/item_models/category_model.dart';
import '/constants.dart';

class NewCategory extends GetView<InventoryController> {
  const NewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          Get.back();
          Get.defaultDialog(
            title: 'New Category'.tr,
            content: Form(
              key: controller.addCategoryFormKey,
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
                      hintText: 'Category name'.tr,
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
                    controller: controller.addCategoryTextController,
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
                            if (controller.addCategoryFormKey.currentState!
                                .validate()) {
                              List<CategoryModel> categories =
                                  await dbController.readCategories();
                              List categoryNames = [];
                              for (var element in categories) {
                                categoryNames.add(element.categoryName);
                              }
                              if (!categoryNames.contains(
                                  controller.addCategoryTextController.text)) {
                                await dbController.addCategory(CategoryModel(
                                    categoryName: controller
                                        .addCategoryTextController.text));
                                controller.categoryList.value =
                                    await dbController.readCategories();
                                controller.addCategoryTextController.clear();
                                Get.back();
                              } else {
                                controller.addCategoryTextController.clear();
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
          );
        },
        leading: Icon(
          Icons.add,
          size: 30,
          color: darkColor,
        ),
        title: Text('New Category'.tr,
            style: TextStyle(
              color: darkColor,
            )),
      ),
    );
  }
}
