import 'package:flutter/material.dart';
import 'package:netflix/constants/size_utils.dart';
import '../../../constants/appcolors.dart';
import 'custom_Button.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(kBackgroundCard))),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  title: "My List",
                  iconName: Icons.add,
                ),
                PlayButton(),
                CustomButton(iconName: Icons.info, title: "info")
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kWhiteColor)),
        onPressed: () {},
        icon: Icon(
          Icons.play_arrow,
          size: 25,
          color: Colors.black,
        ),
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Play",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ));
  }
}
