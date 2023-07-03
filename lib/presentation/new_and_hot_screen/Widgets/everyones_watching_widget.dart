import 'package:flutter/material.dart';
import '../../../constants/appcolors.dart';
import '../../../constants/size_utils.dart';
import '../../home_screen/widgets/custom_Button.dart';
import 'video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String descripition;
  // final String id;

  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.descripition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight10,
        Text(
          movieName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          descripition,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: kGreyColor),
        ),
        kHeight50,
         VideoWidget(
          url: posterPath,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButton(
              iconName: Icons.share,
              title: "Share",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth10,
            CustomButton(
              iconName: Icons.add,
              title: "My List",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth10,
            CustomButton(
              iconName: Icons.play_arrow,
              title: "Play",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth10
          ],
        )
      ],
    );
  }
}
