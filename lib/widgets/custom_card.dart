import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_erp/widgets/glass_container.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String title;
  final void Function() myFunc;
  const CustomCard({
    this.icon,
    this.image,
    required this.title,
    required this.myFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: ListTile(
        leading: icon == null
            ? Image.asset(
                image!,
                height: 25,
                width: 25,
              )
            : Icon(
                icon,
                color: darkColor,
              ),
        title: Text(
          title.tr,
          style: TextStyle(color: lightColor, fontSize: 16),
        ),
        onTap: () => myFunc(),
      ),
    );
  }
}
