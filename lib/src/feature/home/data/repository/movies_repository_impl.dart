import 'package:tmdp_movie_app/src/feature/home/data/model/movies_list_model.dart';
import 'package:tmdp_movie_app/src/feature/network/data/constants/const_api_paths.dart';
import 'package:tmdp_movie_app/src/feature/network/domain/repository/api_request_repository.dart';

import '../../domain/repository/movies_repository.dart';
import '../model/movie_summary_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  const MoviesRepositoryImpl(this.apiRequestRepository);
  final ApiRequestRepository apiRequestRepository;

  @override
  Future<List<MovieSummaryModel>?> getPopularMovies({int page = 1}) async {
    return await _loadMovies(
      page: page,
      moviesListApiPath: ConstApiPaths.popularMovies,
    );
  }

  @override
  Future<List<MovieSummaryModel>?> getNowPlayingMovies({int page = 1}) async {
    return await _loadMovies(
      page: page,
      moviesListApiPath: ConstApiPaths.nowPlayingMovies,
    );
  }

  @override
  Future<List<MovieSummaryModel>?> getTopRatedMovies({int page = 1}) async {
    return await _loadMovies(
      page: page,
      moviesListApiPath: ConstApiPaths.topRatedMovies,
    );
  }

  Future<List<MovieSummaryModel>?> _loadMovies({
    required int page,
    required String moviesListApiPath,
  }) async {
    final Map<String, dynamic>? response =
        await apiRequestRepository.getRequest(
      "${ConstApiPaths.domainLink}$moviesListApiPath?page=$page",
    );
    if (response == null) return null;
    try {
      return MoviesListModel.fromJson(response).results;
    } catch (parseException) {
      // catchRunTimeException(parseException);
      return null;
    }
  }
}
