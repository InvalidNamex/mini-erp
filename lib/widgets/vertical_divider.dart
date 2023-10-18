import 'package:flutter/material.dart';
import '/constants.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: accentColor,
      thickness: 1,
    );
  }
}
