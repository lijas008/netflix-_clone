import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/constants/appcolors.dart';
import 'package:netflix/constants/size_utils.dart';

import 'package:netflix/presentation/search_screen/widgets/search_text_title.dart';

const imageUrl =
    "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/thLAoL6VeZGmCyDpCOeoxLvA8yS.jpg";

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchTextTitle(
          title: "Top Searchs",
        ),
        kHeight10,
        Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, int index) => TopSearchTile(),
                separatorBuilder: (context, int index) => kHeight20,
                itemCount: 10))
      ],
    );
  }
}

class TopSearchTile extends StatelessWidget {
  const TopSearchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        ),
        const Expanded(
            child: Text(
          "Movie Name",
          style: TextStyle(
              color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 14),
        )),
        const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 21,
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            child: Icon(
              CupertinoIcons.play_fill,
              color: kWhiteColor,
            ),
          ),
        )
      ],
    );
  }
}
