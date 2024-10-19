/// Constant app API paths and domains
/// Holds any link that is used for an API request
class ConstApiPaths {
  /// The main app domain link
  static const String domainLink = "https://api.themoviedb.org/$_apiVersion";
  static const String _apiVersion = "3";

  /// Home screen
  /// Popular movies
  static const String popularMovies = "/movie/popular";

  /// Top rated movies
  static const String topRatedMovies = "/movie/top_rated";

  /// Now playing movies
  static const String nowPlayingMovies = "/movie/now_playing";

  /// Movie details
  /// Full movie details
  static String movieDetails(int id) => "/movie/$id";
  static String movieVideos(int id) => "/movie/$id/videos";
}
