part of 'movies_home_bloc.dart';

@immutable
sealed class MoviesHomeState {}

/// Initial bloc State
final class MoviesHomeInitial extends MoviesHomeState {}

/// Done loading state, holds movies lists
/// the lists are nullable in case of an error in loading one of them
final class MoviesHomeDone extends MoviesHomeState {
  final List<MovieSummary>? nowPlayingMovies;
  final List<MovieSummary>? popularMovies;
  final List<MovieSummary>? topRatedMovies;
  final int nowPlayingPage;
  final int popularPage;
  final int topRatedPage;

  MoviesHomeDone({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    this.nowPlayingPage = 1,
    this.popularPage = 1,
    this.topRatedPage = 1,
  });

  MoviesHomeDone copyWith({
    List<MovieSummary>? nowPlayingMovies,
    List<MovieSummary>? popularMovies,
    List<MovieSummary>? topRatedMovies,
    int? nowPlayingPage,
    int? popularPage,
    int? topRatedPage,
  }) {
    return MoviesHomeDone(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
      popularPage: popularPage ?? this.popularPage,
      topRatedPage: topRatedPage ?? this.topRatedPage,
    );
  }
}

/// Screen error case, when all the lists fails to load
final class MoviesHomeError extends MoviesHomeState {}
