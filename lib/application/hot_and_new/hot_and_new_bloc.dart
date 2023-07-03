import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/model/hot_and_new_resp/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService hotAndNewService;
  HotAndNewBloc(this.hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to ui

      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false));

      //get data from remote
      final result = await hotAndNewService.getHotAndNewMovieData();

      // data to state
      final newState = result.fold((MainFailure failure) {
        return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true);
      }, (HotAndNewResp resp) {
        return HotAndNewState(
            comingSoonList: resp.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            isError: false);
      });
      emit(newState);
    });

    on<LoadDataInEveryOneIsWatching>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false));

      //get data from remote
      final result = await hotAndNewService.getHotAndNewTvData();

      final newState = result.fold((MainFailure failure) {
        return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true);
      }, (HotAndNewResp resp) {
        return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyOneIsWatchingList: resp.results,
            isLoading: false,
            isError: false);
      });
      emit(newState);
    });
  }
}
