part of 'movies_home_bloc.dart';

@immutable
sealed class MoviesHomeEvent {}

final class RefreshMoviesEvent extends MoviesHomeEvent {}

final class OpenMovieDetailsEvent extends MoviesHomeEvent {
  OpenMovieDetailsEvent(this.movieId);
  final int movieId;
}

final class OpenMoviesListEvent extends MoviesHomeEvent {
  OpenMoviesListEvent(this.movieType);
  final MovieType movieType;
}
