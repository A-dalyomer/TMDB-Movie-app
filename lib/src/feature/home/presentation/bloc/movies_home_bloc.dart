import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';
import 'package:tmdp_movie_app/src/feature/home/data/model/movie_summary_model.dart';
import 'package:tmdp_movie_app/src/feature/home/data/model/movies_list_model.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/repository/movies_repository.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/util/enum.dart';

import '../../domain/entity/movie_summary.dart';

part 'movies_home_event.dart';
part 'movies_home_state.dart';

class MoviesHomeBloc extends HydratedBloc<MoviesHomeEvent, MoviesHomeState> {
  MoviesHomeBloc(this.moviesRepository) : super(MoviesHomeInitial()) {
    on<RefreshMoviesEvent>((event, emit) async => await getMovies(emit));
    on<OpenMovieDetailsEvent>((even, emit) {});
    on<OpenMoviesListEvent>((even, emit) {});
  }
  final MoviesRepository moviesRepository;

  /// Load all home screen movie section data and emit proper response states
  Future<void> getMovies(Emitter emit) async {
    if (state is MoviesHomeError) emit(MoviesHomeInitial);
    final results = await Future.wait<List<MovieSummary>?>(
      [
        moviesRepository.getNowPlayingMovies(),
        moviesRepository.getPopularMovies(),
        moviesRepository.getTopRatedMovies(),
      ],
    );
    if (checkCompleteFail(results)) {
      emit(MoviesHomeError());
    } else {
      MoviesHomeDone doneState = MoviesHomeDone(
        nowPlayingMovies: results[0],
        popularMovies: results[1],
        topRatedMovies: results[2],
      );
      emit(doneState);
    }
  }

  /// Checks if all lists have failed to load
  /// therefore emit a complete fail state
  bool checkCompleteFail(List<List<MovieSummary>?> results) {
    for (var result in results) {
      if (result != null) return false;
    }
    return true;
  }

  @override
  MoviesHomeState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return null;
    return MoviesHomeDone(
      nowPlayingMovies: MoviesListModel.fromJson(json['top_rated']).results,
      popularMovies: MoviesListModel.fromJson(json['popular']).results,
      topRatedMovies: MoviesListModel.fromJson(json['now_playing']).results,
    );
  }

  @override
  Map<String, dynamic>? toJson(MoviesHomeState state) {
    switch (state) {
      case MoviesHomeDone _:
        return {
          'top_rated': state.topRatedMovies
              ?.map((element) => MovieSummaryModel.fromEntity(element).toJson())
              .toList()
              .sublist(0, ConstConfig.cacheListSize - 1),
          'popular': state.popularMovies
              ?.map((element) => MovieSummaryModel.fromEntity(element).toJson())
              .toList()
              .sublist(0, ConstConfig.cacheListSize - 1),
          'now_playing': state.nowPlayingMovies
              ?.map((element) => MovieSummaryModel.fromEntity(element).toJson())
              .toList()
              .sublist(0, ConstConfig.cacheListSize - 1),
        };
      case MoviesHomeError _:
      default:
        return {};
    }
  }
}