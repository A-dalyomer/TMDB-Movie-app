import 'package:tmdp_movie_app/src/feature/movie_details/data/model/movie_details_model.dart';
import 'package:tmdp_movie_app/src/feature/network/data/constants/const_api_paths.dart';
import 'package:tmdp_movie_app/src/feature/network/domain/repository/api_request_repository.dart';

import '../../domain/repository/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  MovieDetailsRepositoryImpl({required this.apiRequestRepository});
  final ApiRequestRepository apiRequestRepository;

  @override
  Future<MovieDetailsModel?> getMovieDetails(int movieId) async {
    final response = await apiRequestRepository.getRequest(
      ConstApiPaths.movieDetails(movieId),
    );
    if (response == null) return null;
    try {
      return MovieDetailsModel.fromJson(response);
    } catch (exception) {
      // catchRunTimeException(parseException);
      return null;
    }
  }
}
