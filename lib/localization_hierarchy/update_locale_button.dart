import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

final locales = [
  {'name': 'English', 'locale': const Locale('en', 'US')},
  {'name': 'عربي', 'locale': const Locale('ar', 'EG')},
];
showLocaleDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(
              'Choose Your Language'.tr,
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            locales[index]['name'].toString(),
                          ),
                        ),
                        onTap: () {
                          updateLocale(locales[index]['locale'] as Locale);
                        },
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                      ),
                  itemCount: 2),
            ),
          ));
}

updateLocale(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
  if (locale == const Locale('ar', 'EG')) {
    localizationController.saveLocale('ar');
  } else {
    localizationController.saveLocale('en');
  }
}
/**
    ----------- Under GetMaterialApp --------------
    locale: Get.deviceLocale,
    Pass this in onPressed to the button used to choose language
    showLocaleDialog(context);
    to translate text append .tr to string
    "button1".tr,
 **/
