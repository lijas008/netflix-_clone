import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/constants/appcolors.dart';
import 'package:netflix/constants/size_utils.dart';
import 'package:netflix/domain/downloads/models/downloads_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemsInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemsInheritedWidget(
      {super.key, required this.widget, required this.movieData})
      : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemsInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemsInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemsInheritedWidget>();
  }
}

class VideoListItems extends StatelessWidget {
  const VideoListItems({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final videoUrl = dummyVideoUrl[index % dummyVideoUrl.length];
    final posterPath =
        VideoListItemsInheritedWidget.of(context)?.movieData.posterPath;
    return Stack(
      children: [
        // Container(
        //   color: Colors.accents[index % Colors.accents.length],
        // ),
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundColor: backgroundColor.withOpacity(.5),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.volume_off,
                          color: kWhiteColor,
                          size: 25,
                        ))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        backgroundImage: posterPath == null
                            ? null
                            // : NetworkImage("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/1NxaSn4ver4jIvLeD7YF8cTlZjB.jpg"),
                            : NetworkImage('$imageAppendUrl$posterPath'),
                        radius: 25,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoIdsNotifier,
                      builder: (BuildContext context, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              // BlocProvider.of<FastLaughBloc>(context)
                              //     .add(UnLikeVideo(id: _index));
                              likedVideoIdsNotifier.value.remove(_index);
                              likedVideoIdsNotifier.notifyListeners();
                            },
                            child: const VideoAction(
                                iconName: Icons.favorite, title: "Liked"),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            // BlocProvider.of<FastLaughBloc>(context)
                            //     .add(LikeVideo(id: _index));
                            likedVideoIdsNotifier.value.add(_index);
                            likedVideoIdsNotifier.notifyListeners();
                          },
                          child: const VideoAction(
                              iconName: Icons.emoji_emotions, title: "LOL"),
                        );
                      },
                    ),
                    const VideoAction(
                      iconName: Icons.add,
                      title: "My List",
                    ),
                    GestureDetector(
                        onTap: () {
                          final movieName =
                              VideoListItemsInheritedWidget.of(context)
                                  ?.movieData
                                  .title;
                          if (movieName != null) {
                            Share.share(movieName);
                          }
                        },
                        child:
                            VideoAction(iconName: Icons.share, title: "Share")),
                    VideoAction(iconName: Icons.play_arrow, title: "Play"),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoAction extends StatelessWidget {
  const VideoAction({super.key, required this.iconName, required this.title});
  final IconData iconName;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            iconName,
            color: kWhiteColor,
            size: 25,
          ),
          Text(
            title,
            style: const TextStyle(color: kWhiteColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      setState(() {
        videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController))
          : const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
