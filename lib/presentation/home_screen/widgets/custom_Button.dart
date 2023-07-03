import 'package:flutter/material.dart';

import '../../../constants/appcolors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.iconName,
      required this.title,
      this.iconSize = 25,
      this.textSize = 18});
  final IconData iconName;
  final String title;
  final double iconSize;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconName,
          color: kWhiteColor,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(fontSize: textSize),
        )
      ],
    );
  }
}
