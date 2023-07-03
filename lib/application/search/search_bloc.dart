import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads_model.dart';
import '../../domain/search/models/search_response/search_response.dart';
import '../../domain/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo downloadsService;
  final SearchService searchService;
  SearchBloc(this.downloadsService, this.searchService)
      : super(SearchState.initial()) {
    //idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
            searchResultList: [],
            idleList: state.idleList,
            isLoading: false,
            isError: false));
        return;
      }
      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));

      //get trending
      final result = await downloadsService.getDownloadsImages();
      final res = result.fold((MainFailure f) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true);
      }, (List<Downloads> list) {
        return SearchState(
            searchResultList: [],
            idleList: list,
            isLoading: false,
            isError: false);
      });
      //show to ui
      emit(res);
    });

//search result state
    on<SearchMovie>((event, emit) async {
      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));
      final res =
          await searchService.searchMovies(movieQuery: event.movieQuery);
      final state = res.fold((MainFailure f) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: true,
            isError: false);
      }, (SearchResponse s) {
        return SearchState(
            searchResultList: s.results,
            idleList: [],
            isLoading: false,
            isError: false);
      });
      // call search movie api
      emit(state);
    });
  }
}
