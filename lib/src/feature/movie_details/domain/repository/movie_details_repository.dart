import '../../data/model/movie_details_model.dart';

/// Movie details repository document
/// Handles requesting movie details API calls
abstract class MoviesRepository {
  /// Get movie details
  Future<MovieDetailsModel?> getMovieDetails();
}
