import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_erp/constants.dart';
import 'package:mini_erp/models/item_models/item_price_list_model.dart';
import 'package:mini_erp/models/item_models/item_taxes_model.dart';
import 'package:mini_erp/models/item_models/taxes_model.dart';

import '../models/item_models/category_model.dart';
import '../models/item_models/price_list_model.dart';

class InventoryController extends GetxController {
  static InventoryController instance = Get.find();
  final TextEditingController categorySearchTextController =
      TextEditingController();
  // category
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<String> categoryNamesList = <String>[].obs;
  final GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editCategoryFormKey = GlobalKey<FormState>();
  TextEditingController addCategoryTextController = TextEditingController();
  TextEditingController editCategoryTextController = TextEditingController();
  // PRICE LIST
  List<ItemPriceListModel> priceListValues = [];
  RxList<PriceListModel> priceListNamesList = <PriceListModel>[].obs;
  final GlobalKey<FormState> addPriceListFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editPriceListFormKey = GlobalKey<FormState>();
  TextEditingController addPriceListTextController = TextEditingController();
  TextEditingController editPriceListTextController = TextEditingController();

  Future<void> populatePriceList() async {
    priceListNamesList.value = await dbController.readPriceListNames();
  }

  Future<void> populateCategoryList() async {
    List<CategoryModel> _y = await dbController.readCategoryNames();
    List<String> _x = [];
    if (_y.isNotEmpty) {
      for (int i = 0; i < _y.length; i++) {
        _x.add(_y[i].categoryName!);
      }
    } else {
      _x.add('General'.tr);
    }
    categoryNamesList.value = _x;
  }

  TableRow priceListTableHeaders = TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Price List Name'.tr,
        style: TextStyle(
            color: accentColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Value'.tr,
        style: TextStyle(
            color: accentColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
  ]);
  RxList<TableRow> priceTableRows() {
    RxList<TableRow> priceTableRows = RxList();
    priceTableRows.insert(0, priceListTableHeaders);
    for (int i = 0; i < priceListNamesList.length; i++) {
      var _c = priceListNamesList[i];
      TextEditingController priceListTextController =
          TextEditingController(text: '0');
      priceTableRows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _c.priceListName!,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: priceListTextController,
              keyboardType: TextInputType.number,
              onTap: () {
                priceListTextController.clear();
              },
              onTapOutside: (w) {
                if (priceListTextController.text != '0' &&
                    priceListTextController.text.isNotEmpty) {
                  ItemPriceListModel newItem = ItemPriceListModel(
                      priceListID: _c.priceListID,
                      price: double.parse(priceListTextController.text));
                  priceListValues =
                      addPriceListIfNotExists(priceListValues, newItem);
                }
              },
            )),
      ]));
    }
    return priceTableRows;
  }

  List<ItemPriceListModel> addPriceListIfNotExists(
      List<ItemPriceListModel> itemList, ItemPriceListModel newItem) {
    bool priceListIDExists = false;

    // Check if newItem's taxID already exists in the list
    for (var item in itemList) {
      if (item.priceListID == newItem.priceListID) {
        priceListIDExists = true;
        itemList.remove(item);
        itemList.add(newItem);
        break;
      }
    }

    // If taxID doesn't exist in the list, add newItem
    if (!priceListIDExists) {
      itemList.add(newItem);
    }

    return itemList;
  }

  //New Product
  final GlobalKey<FormState> newProductFormKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productOpeningQuantity =
      TextEditingController(text: '0.0');
  TextEditingController productOpeningPrice =
      TextEditingController(text: '0.0');
  TextEditingController productMinQuantity = TextEditingController(text: '0.0');

  // Taxes
  List<ItemTaxesModel> taxesValues = [];
  RxList<TaxesModel> taxesNamesList = <TaxesModel>[].obs;
  final GlobalKey<FormState> addTaxFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> taxTableFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editTaxFormKey = GlobalKey<FormState>();
  TextEditingController addTaxTextController = TextEditingController();
  TextEditingController editTaxTextController = TextEditingController();
  Future<void> populateTaxes() async {
    taxesNamesList.value = await dbController.readTaxesNames();
  }

  TableRow taxTableHeaders = TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Tax Name'.tr,
        style: TextStyle(
            color: accentColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Tax Percentage %'.tr,
        style: TextStyle(
            color: accentColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
  ]);
  RxList<TableRow> tableRows() {
    RxList<TableRow> tableRows = RxList();
    tableRows.insert(0, taxTableHeaders);
    for (int i = 0; i < taxesNamesList.length; i++) {
      var _c = taxesNamesList[i];
      TextEditingController order = TextEditingController(text: '0');
      tableRows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _c.taxName!,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: order,
              keyboardType: TextInputType.number,
              onTap: () {
                order.clear();
              },
              onTapOutside: (w) {
                if (order.text != '0' && order.text.isNotEmpty) {
                  ItemTaxesModel newItem = ItemTaxesModel(
                      taxID: _c.taxID, taxPercentage: int.parse(order.text));
                  taxesValues = addTaxIfNotExists(taxesValues, newItem);
                }
              },
            )),
      ]));
    }
    return tableRows;
  }

  List<ItemTaxesModel> addTaxIfNotExists(
      List<ItemTaxesModel> itemList, ItemTaxesModel newItem) {
    bool taxIDExists = false;

    // Check if newItem's taxID already exists in the list
    for (var item in itemList) {
      if (item.taxID == newItem.taxID) {
        taxIDExists = true;
        itemList.remove(item);
        itemList.add(newItem);
        break;
      }
    }

    // If taxID doesn't exist in the list, add newItem
    if (!taxIDExists) {
      itemList.add(newItem);
    }

    return itemList;
  }

  @override
  void onInit() async {
    categoryList.value = await dbController.readCategories();
    await populateTaxes();
    await populatePriceList();
    await populateCategoryList();
    super.onInit();
  }
}
