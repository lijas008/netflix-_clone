import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/constants/appcolors.dart';

import '../../../constants/size_utils.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index, required this.imageUrl});
  final int index;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              // height: 150,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: kRadius10,
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          // "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/dBxxtfhC4vYrxB2fLsSxOTY2dQc.jpg"
                          imageUrl
                          ))),
            ),
          ],
        ),
        Positioned(
          left: 14,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
