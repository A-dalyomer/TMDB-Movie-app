part of 'movie_details_bloc.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsDone extends MovieDetailsState {
  MovieDetailsDone({
    required this.movieDetails,
    required this.movieVideoKeys,
  });
  final MovieDetails movieDetails;
  final List<String> movieVideoKeys;
}

final class MovieDetailsError extends MovieDetailsState {}
