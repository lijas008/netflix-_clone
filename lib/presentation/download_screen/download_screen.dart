import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/download_bloc/downloads_bloc.dart';
import 'package:netflix/constants/appcolors.dart';
import 'package:netflix/constants/size_utils.dart';
import 'package:netflix/presentation/common/app_bar_widget.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({super.key});
  final widgetList = [
    const SectionOne(),
    const SectionTwo(),
    const SectionThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(title: "Downloads")),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          itemCount: widgetList.length,
          separatorBuilder: (context, int index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, int index) => widgetList[index],
        ));
  }
}

class SectionOne extends StatelessWidget {
  const SectionOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth10,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth10,
        Text("Smart Downloads")
      ],
    );
  }
}

class DownloadImageList extends StatelessWidget {
  const DownloadImageList(
      {super.key,
      required this.imageList,
      required this.margin,
      required this.size,
      this.angle = 0,
      this.radius = 10});

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageList))),
        ),
      ),
    );
  }
}

class SectionTwo extends StatelessWidget {
  const SectionTwo({super.key});
  // final imageList = [
  //   "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/v7UF7ypAqjsFZFdjksjQ7IUpXdn.jpg",
  //   "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/9JBEPLTPSm0d1mbEcLxULjJq9Eh.jpg",
  //   "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/6NgLGcOHscy6yLXpKCQi4Mz1yVa.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<DownloadsBloc>(context)
            .add(const DownloadsEvent.getDownloadsImages());
      },
    );

    return Column(
      children: [
        const Text(
          "Introducing Downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kHeight10,
        const Text(
          "We will download a personlised selection of\n movies and shows for you,so there's\n is alaways something to watch on your\n device",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.downloads.isEmpty
                      ? const Text("No Data")
                      : Stack(alignment: Alignment.center, children: [
                          CircleAvatar(
                            radius: size.width * .38,
                            backgroundColor: Colors.grey.withOpacity(.5),
                          ),
                          DownloadImageList(
                            imageList:
                                '$imageAppendUrl${state.downloads[0].posterPath}',
                            // imageList: imageList[0],
                            margin:
                                const EdgeInsets.only(left: 185, bottom: 50),
                            angle: 25,
                            size: Size(size.width * .3, size.height * .29),
                          ),
                          DownloadImageList(
                            imageList:
                                '$imageAppendUrl${state.downloads[1].posterPath}',
                            // imageList: imageList[1],
                            margin:
                                const EdgeInsets.only(right: 185, bottom: 50),
                            angle: -25,
                            size: Size(size.width * .3, size.height * .29),
                          ),
                          DownloadImageList(
                              imageList:
                                  '$imageAppendUrl${state.downloads[2].posterPath}',
                              // imageList: imageList[2],
                              margin: const EdgeInsets.only(bottom: 2),
                              radius: 10,
                              size: Size(size.width * .5, size.height * .32)),
                        ]),
            );
          },
        ),
      ],
    );
  }
}

class SectionThree extends StatelessWidget {
  const SectionThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: kButtonColorBlue,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set up",
                style: TextStyle(
                    color: kButtonColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: kButtonColorWhite,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See what you can download",
              style: TextStyle(
                  color: kButtonColorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
