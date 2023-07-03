import 'package:flutter/material.dart';
import '../../../constants/appcolors.dart';
import '../../../constants/size_utils.dart';
import '../../home_screen/widgets/custom_Button.dart';
import 'video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String descripition;

  const ComingSoonWidget(
      {super.key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterPath,
      required this.movieName,
      required this.descripition});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                month,
                style: const TextStyle(fontSize: 16, color: kGreyColor),
              ),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               VideoWidget(url: posterPath),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: -5
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      CustomButton(
                        iconName: Icons.notifications_outlined,
                        title: "Remaind Me",
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kWidth10,
                      CustomButton(
                        iconName: Icons.info,
                        title: "info",
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kWidth10,
                    ],
                  )
                ],
              ),
              kHeight10,
              Text("Coming on $day $month"),
              kHeight10,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                descripition,
                maxLines: 4,
                // "It has been a year since Mic Mic and Oscar returned from their incredible adventure. And now, after a \ndiabolical plan by Vulture to sabotage the delivery ofthe Grizzly cub to his opponent in the American presidential elections, Mic Mic, Oscar, Panda teenager and Stork set off on another great adventure as they ride a zeppelin to \nreturn little Grizzly to its rightful parents and save the American elections and the whole continent from an erupting volcano.",
                style: const TextStyle(color: kGreyColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
