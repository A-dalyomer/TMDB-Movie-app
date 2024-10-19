import '../../data/model/movie_summary_model.dart';

/// Movies repository document
/// Handles requesting home screen API calls
abstract class MoviesRepository {
  /// Get popular movies
  Future<List<MovieSummaryModel>?> getPopularMovies({int page = 1});

  /// Get now playing movies
  Future<List<MovieSummaryModel>?> getNowPlayingMovies({int page = 1});

  /// Get top rated movies
  Future<List<MovieSummaryModel>?> getTopRatedMovies({int page = 1});
}
