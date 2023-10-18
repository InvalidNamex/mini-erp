import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../localization_hierarchy/update_locale_button.dart';
import '../widgets/home_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        centerTitle: true,
        title: const Text('Mini ERP'),
      ),
      endDrawer: homeDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpeg'), fit: BoxFit.fill)),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: Get.height / 4 - 20, crossAxisCount: 2),
          children: const [
            HomeTile(
                title: 'Sales', image: 'assets/sales.webp', navigate: '/sales'),
            HomeTile(
                title: 'Purchases',
                image: 'assets/purchase.webp',
                navigate: ''),
            HomeTile(
                title: 'Vendors', image: 'assets/vendor.webp', navigate: ''),
            HomeTile(
                title: 'Clients', image: 'assets/client.webp', navigate: ''),
            HomeTile(
                title: 'Expenses', image: 'assets/expense.webp', navigate: ''),
            HomeTile(title: 'Cash', image: 'assets/cash.webp', navigate: ''),
            HomeTile(
                title: 'Reports', image: 'assets/reports.webp', navigate: ''),
            HomeTile(
                title: 'Inventory',
                image: 'assets/inventory.webp',
                navigate: '/inventory'),
          ],
        ),
      ),
    );
  }

  Drawer homeDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        padding: const EdgeInsets.all(7),
        children: [
          Row(
            children: [
              Image.asset('assets/logo.png'),
              Column(
                children: [
                  Text(
                    'Mini ERP',
                    style: TextStyle(
                        color: accentColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'by: Ahmed Hassan',
                    style: TextStyle(
                        color: accentColor, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Text(
            'General settings'.tr,
            style: TextStyle(color: accentColor),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.abc_outlined, color: lightColor),
            onTap: () => showLocaleDialog(context),
            title: Text(
              'Language'.tr,
              style: TextStyle(color: lightColor),
            ),
          )
        ],
      ),
    );
  }
}
