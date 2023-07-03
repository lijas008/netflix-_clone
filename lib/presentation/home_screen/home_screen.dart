import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/constants/size_utils.dart';
import 'package:netflix/presentation/common/main_title_card.dart';
import 'package:netflix/presentation/home_screen/widgets/number_title_card.dart';
import '../../constants/appcolors.dart';
import 'widgets/background_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, value, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.isError) {
                    return const Center(
                      child: Text(
                        "Error while getting data",
                        style: TextStyle(color: kWhiteColor),
                      ),
                    );
                  }
                  //released in past year
                  final releasedPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //trending movies
                  final trending = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //tensed Dramas

                  final tensedDramas = state.tensedMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  // South Indian movies

                  final southIndian = state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  southIndian.shuffle();

                  //tv shows
                  final topTenShows = state.trendingTvList.map((t) {
                    return '$imageAppendUrl${t.posterPath}';
                  }).toList();
                  topTenShows.shuffle();
                  return ListView(
                    children: [
                      BackgroundCard(),
                      MainTitleCard(
                          title: "Released In Past Year",
                          posterList: releasedPastYear),
                      kHeight10,
                      MainTitleCard(
                        title: "Trending Now",
                        posterList: trending,
                      ),
                      NumberTitleCard(posterList: topTenShows),
                      kHeight10,
                      MainTitleCard(
                          title: "Tensed Dramas", posterList: tensedDramas),
                      kHeight10,
                      MainTitleCard(
                          title: "South Indian Movies", posterList: southIndian)
                    ],
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(microseconds: 1000),
                      width: double.infinity,
                      height: 80,
                      color: Colors.black.withOpacity(.3),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Image.network(
                                  "https://cdn-images-1.medium.com/v2/resize:fit:1200/1*ty4NvNrGg4ReETxqU2N3Og.png",
                                  width: 50,
                                  height: 50,
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Tv Shows",
                                style: kHomeTitleText,
                              ),
                              Text(
                                "Movies",
                                style: kHomeTitleText,
                              ),
                              Text(
                                "Categories",
                                style: kHomeTitleText,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : kHeight10
            ],
          ),
        );
      },
    ));
  }
}
