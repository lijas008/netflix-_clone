import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/constants/appcolors.dart';
import 'package:netflix/constants/size_utils.dart';
import 'package:netflix/presentation/search_screen/widgets/search_text_title.dart';

// const imageUrl =
//     "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/thLAoL6VeZGmCyDpCOeoxLvA8yS.jpg";

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
        Expanded(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isError) {
              return const Center(
                child: Text("Error while getting data"),
              );
            } else if (state.idleList.isEmpty) {
              return const Center(
                child: Text("List is empty"),
              );
            }
            return ListView.separated(
                itemBuilder: (context, int index) {
                  final movie = state.idleList[index];
                  return TopSearchTile(
                      title: movie.title ?? "No title provided",
                      imageUrl: "$imageAppendUrl${movie.posterPath}");
                },
                separatorBuilder: (context, int index) => kHeight20,
                itemCount: state.idleList.length);
          },
        ))
      ],
    );
  }
}

class TopSearchTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchTile({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
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
