import 'package:flutter/material.dart';
import 'package:netflix/constants/size_utils.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const Spacer(),
          const Icon(
            Icons.cast,
            size: 30,
            color: Colors.white,
          ),
          kWidth10,
          Container(
            height: 30,
            width: 30,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
