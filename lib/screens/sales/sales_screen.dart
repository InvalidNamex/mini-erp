import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants.dart';
import '../../widgets/barcode_scanner.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkColor,
          centerTitle: true,
          title: Text('Sales'.tr),
          bottom: TabBar(
            indicatorColor: accentColor,
            isScrollable: true,
            tabs: [
              Tab(text: '${'POS'.tr} 1'),
              Tab(text: '${'POS'.tr} 2'),
              Tab(text: '${'POS'.tr} 3'),
              Tab(text: '${'POS'.tr} 4'),
              Tab(text: '${'POS'.tr} 5'),
            ],
          ),
        ),
        endDrawer: const Drawer(),
        body: TabBarView(
          children: [
            const SalesPOS(),
            Center(child: Text('Content for Tab 2'.tr)),
            Center(child: Text('Content for Tab 3'.tr)),
            Center(child: Text('Content for Tab 4'.tr)),
            Center(child: Text('Content for Tab 5'.tr)),
          ],
        ),
      ),
    );
  }
}

class SalesPOS extends StatelessWidget {
  const SalesPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                tooltip: 'Pay'.tr,
                icon: Icon(Icons.monetization_on_outlined, color: darkColor),
                onPressed: () {},
              ),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  hintText:
                      'Search by id or name'.tr, // Set your hint text here
                ),
                controller: homeController.salesSearchBox,
              )),
              IconButton(
                  tooltip: 'Clients'.tr,
                  onPressed: () async {},
                  icon: Icon(
                    Icons.account_box_rounded,
                    color: darkColor,
                  )),
              IconButton(
                  onPressed: () async {
                    homeController.salesSearchBox.clear();
                    homeController.salesSearchBox.text = await barcodeScanner();
                  },
                  tooltip: 'Barcode Scanner'.tr,
                  icon: Icon(
                    Icons.qr_code,
                    color: darkColor,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
