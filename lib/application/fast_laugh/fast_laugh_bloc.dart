import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads_model.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrl = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
];
ValueNotifier<Set<int>> likedVideoIdsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(IDownloadsRepo downloadService)
      : super(FastLaughState.initial()) {
    on<Initilize>((event, emit) async {
      //sendingloading to UI
      emit(const FastLaughState(
        videoList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending movies

      final result = await downloadService.getDownloadsImages();
      final _state = result.fold((l) {
        return FastLaughState(
          videoList: [],
          isLoading: false,
          isError: true,
        );
      },
          (resp) => FastLaughState(
                videoList: resp,
                isLoading: false,
                isError: false,
              ));

      //send to ui

      emit(_state);
    });
    on<LikeVideo>((event, emit) {
      likedVideoIdsNotifier.value.add(event.id);
      likedVideoIdsNotifier.notifyListeners();
    });
    on<UnLikeVideo>((event, emit) async {
      likedVideoIdsNotifier.value.remove(event.id);
      likedVideoIdsNotifier.notifyListeners();
    });
  }
}
