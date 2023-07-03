import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/constants/appcolors.dart';
import '../../constants/size_utils.dart';
import 'Widgets/coming_soon_widget.dart';
import 'Widgets/everyones_watching_widget.dart';

class NewAndHotScreen extends StatelessWidget {
  const NewAndHotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                title: const Text("New & Hot",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                actions: [
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
                  ),
                  kWidth10,
                ],
                bottom: TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                        borderRadius: kRadius30, color: kWhiteColor),
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelColor: kWhiteColor,
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        text: "🍿 Comming Soon",
                      ),
                      Tab(
                        text: "👀 Everyone's Watching",
                      )
                    ]),
              )),
          body: const TabBarView(children: [
            ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryoneIsWatchingList(
              key: Key('everyoneIsWatching'),
            )
          ])),
    );
  }
  // Widget bulidCommingSoon() {
  //   return ListView.builder(
  //     itemCount: 10,
  //     itemBuilder: (context, index) {
  //       return const ComingSoonWidget();
  //     },
  //   );
  // }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          } else if (state.isError) {
            return const Center(
              child: Text("Error while loading coming list"),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text("Coming sson list is empty"),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final date = DateTime.parse(movie.releaseDate!);
                  final formattedDate = DateFormat.yMMMMd('en_US').format(date);
                  // print(formattedDate);
                  // print(movie.releaseDate!);
                  return ComingSoonWidget(
                      id: movie.id.toString(),
                      month: formattedDate
                          .split(' ')
                          .first
                          .substring(0, 3)
                          .toUpperCase(),
                      day: movie.releaseDate!.split('-')[1],
                      posterPath: '$imageAppendUrl${movie.posterPath}',
                      movieName: movie.originalTitle ?? 'No Title',
                      descripition: movie.overview ?? 'No Overview');
                  //   return ComingSoonWidget(id: id, month: month, day: day, posterPath: posterPath, movieName: movieName, descripition: descripition)
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async{
         BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          } else if (state.isError) {
            return const Center(
              child: Text("Error while loading coming list"),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("Coming sson list is empty"),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.everyOneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.everyOneIsWatchingList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
    
                  final tv = state.everyOneIsWatchingList[index];
                  return EveryonesWatchingWidget(
                      posterPath: '$imageAppendUrl${tv.posterPath}',
                      movieName: tv.originalName ?? "No Movie Name",
                      descripition: tv.overview ?? "No OverView");
                  //   return ComingSoonWidget(id: id, month: month, day: day, posterPath: posterPath, movieName: movieName, descripition: descripition)
                });
          }
        },
      ),
    );
  }
}
