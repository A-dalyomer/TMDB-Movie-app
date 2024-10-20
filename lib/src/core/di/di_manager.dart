import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tmdp_movie_app/src/feature/home/data/repository/movies_repository_impl.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/repository/movies_repository.dart';
import 'package:tmdp_movie_app/src/feature/network/data/repository/api_request_repository_impl.dart';
import 'package:tmdp_movie_app/src/feature/network/domain/repository/api_request_repository.dart';
import 'package:tmdp_movie_app/src/feature/network/domain/util/api_general_handler.dart';

/// App Dependency injections handler
/// Used to provide a static dependency instance of [GetIt] currently
/// Allows calling all injections
class DIManager {
  /// The dependency injection singleton instance
  static final getIt = GetIt.instance;

  /// Initializes all needed app injections
  static Future<void> initAppInjections() async {
    /// API Related
    getIt.registerSingleton<APIRequestHandlers>(APIRequestHandlers());
    getIt.registerSingleton<http.Client>(http.Client());
    getIt.registerSingleton<ApiRequestRepository>(
      ApiRequestRepositoryImpl(
        apiClient: getIt<http.Client>(),
        apiRequestHandlers: getIt<APIRequestHandlers>(),
      ),
    );

    /// Movies home
    getIt.registerSingleton<MoviesRepository>(
      MoviesRepositoryImpl(
        getIt<ApiRequestRepository>(),
      ),
    );
  }
}
