import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/model/hot_and_new_resp/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService homeService;

  HomeBloc(this.homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      emit(state.copyWith(isLoading: true, isError: false));

      //send load to ui

      //get data
      final movieResult = await homeService.getHotAndNewMovieData();
      final tvResult = await homeService.getHotAndNewTvData();

      // transform data

      final stateOne = movieResult.fold((MainFailure failure) {
        return HomeState(
            pastYearMovieList: [],
            trendingMovieList: [],
            tensedMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            isLoading: false,
            isError: true);
      }, (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final drama = resp.results;
        final southIndian = resp.results;

        pastYear.shuffle();
        trending.shuffle();
        drama.shuffle();
        southIndian.shuffle();

        return HomeState(
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tensedMovieList: drama,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            isLoading: false,
            isError: false);
      });
      emit(stateOne);

      final stateTwo = tvResult.fold((MainFailure failure) {
        return HomeState(
            pastYearMovieList: [],
            trendingMovieList: [],
            tensedMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            isLoading: false,
            isError: true);
      }, (HotAndNewResp resp) {
        final topTenList = resp.results;
        return HomeState(
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: topTenList,
            tensedMovieList: state.tensedMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: topTenList,
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            isLoading: false,
            isError: false);
      });

      //send to ui
      emit(stateTwo);
    });
  }
}
