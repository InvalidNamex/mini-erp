import 'package:flutter/material.dart';
import 'package:mini_erp/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: darkColor,
      ),
    );
  }
}
