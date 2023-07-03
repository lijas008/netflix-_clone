import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads_model.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;

  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.intial()) {
    on<_GetDownloadImages>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          downloadFailureOrSuccessOption: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();
      // print(downloadsOption.toString());

      emit(downloadsOption.fold(
          (failure) => state.copyWith(
              isLoading: false,
              downloadFailureOrSuccessOption: Some(Left(failure))),
          (success) => state.copyWith(
              isLoading: false,
              downloads: success,
              downloadFailureOrSuccessOption: Some(Right(success)))));
    });
  }
}
