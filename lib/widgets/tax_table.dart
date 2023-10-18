import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

Widget buildTaxBatteryTable() {
  inventoryController.populateTaxes();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Obx(
        () => Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          textDirection: Get.locale! == const Locale('ar', 'EG')
              ? TextDirection.rtl
              : TextDirection.ltr,
          columnWidths: const {
            0: IntrinsicColumnWidth(flex: 5),
            1: IntrinsicColumnWidth(flex: 5),
          },
          border: TableBorder.all(width: 1.0, color: darkColor),
          children: inventoryController.tableRows(),
        ),
      ),
    ],
  );
}

Widget buildPriceListBatteryTable() {
  inventoryController.populatePriceList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Obx(
        () => Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          textDirection: Get.locale! == const Locale('ar', 'EG')
              ? TextDirection.rtl
              : TextDirection.ltr,
          columnWidths: const {
            0: IntrinsicColumnWidth(flex: 5),
            1: IntrinsicColumnWidth(flex: 5),
          },
          border: TableBorder.all(width: 1.0, color: darkColor),
          children: inventoryController.priceTableRows(),
        ),
      ),
    ],
  );
}
