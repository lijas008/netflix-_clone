import 'package:flutter/material.dart';

import '../../../constants/size_utils.dart';
import '../../common/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key, required this.posterList,
  });
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(
          title: "Top 10 TV Shows In India Today",
        ),
        kHeight10,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  posterList.length,
                  (index) => NumberCard(
                    imageUrl: posterList[index],
                        index: index,
                      ))),
        ),
      ],
    );
  }
}
