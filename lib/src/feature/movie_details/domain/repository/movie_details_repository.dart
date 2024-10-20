import '../../data/model/movie_details_model.dart';

/// Movie details repository document
/// Handles requesting movie details API calls
abstract class MovieDetailsRepository {
  /// Get movie details
  Future<MovieDetailsModel?> getMovieDetails(int movieId);
}
