part of 'movie_details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

final class LoadMovieDetailsEvent extends MovieDetailsEvent {
  LoadMovieDetailsEvent({required this.movieId});

  final int movieId;
}
