part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tensedMovieList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingTvList,
    required String stateId,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory HomeState.initial() =>  const HomeState(
    stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tensedMovieList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      isError: false);
}
