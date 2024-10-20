part of 'movies_home_bloc.dart';

@immutable
sealed class MoviesHomeEvent {}

final class RefreshMoviesEvent extends MoviesHomeEvent {}

final class OpenMovieDetailsEvent extends MoviesHomeEvent {
  OpenMovieDetailsEvent(this.context, this.movie);
  final BuildContext context;
  final MovieSummary movie;
}

final class OpenMoviesListEvent extends MoviesHomeEvent {
  OpenMoviesListEvent(this.context, this.movieType, this.movies);
  final BuildContext context;
  final MovieType movieType;
  final List<MovieSummary> movies;
}
