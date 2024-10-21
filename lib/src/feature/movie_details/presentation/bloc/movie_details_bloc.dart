import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/entity/movie_details.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/repository/movie_details_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(this.movieDetailsRepository) : super(MovieDetailsInitial()) {
    on<LoadMovieDetailsEvent>(loadMovieDetails);
    on<OpenMovieTrailerEvent>(openMovieTrailer);
  }

  final MovieDetailsRepository movieDetailsRepository;

  Future<void> loadMovieDetails(
    LoadMovieDetailsEvent event,
    Emitter emit,
  ) async {
    final MovieDetails? movieDetails =
        await movieDetailsRepository.getMovieDetails(event.movieId);
    final movieVideoKeys =
        await movieDetailsRepository.getTrailerKeys(event.movieId);
    if (movieDetails == null) {
      emit(
        MovieDetailsError(),
      );
    } else {
      emit(
        MovieDetailsDone(
          movieDetails: movieDetails,
          movieVideoKeys: movieVideoKeys,
        ),
      );
    }
  }

  /// Launch video trailer on youtube
  /// No can launch checks since youtube will return false on new android versions
  Future<void> openMovieTrailer(
    OpenMovieTrailerEvent event,
    Emitter emit,
  ) async {
    await launchUrlString(ConstConfig.posterVideoBase(event.movieKey));
  }
}
