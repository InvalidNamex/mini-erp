import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_erp/widgets/glass_container.dart';

import '../constants.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String image;
  final String navigate;
  const HomeTile({
    required this.title,
    required this.image,
    required this.navigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.toNamed(navigate),
        child: GlassContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 70,
              width: 70,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title.tr,
              style: TextStyle(
                  color: lightColor, fontWeight: FontWeight.w500, fontSize: 22),
            ),
          ],
        )));
  }
}
