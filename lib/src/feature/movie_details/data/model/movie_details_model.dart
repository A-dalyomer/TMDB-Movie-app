import 'package:tmdp_movie_app/src/feature/movie_details/data/model/genre_model.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/data/model/production_company_model.dart';

import '../../domain/entity/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    required super.posterImage,
    required super.description,
    required super.dateTime,
    required super.genres,
    required super.productionCompanies,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      title: json['original_title'],
      posterImage: json['poster_path'],
      description: json['overview'] ?? '',
      dateTime: DateTime.tryParse(json['release_date']) ?? DateTime.now(),
      genres: List.from(
        json['genres'],
      ).map((e) => GenreModel.fromJson(e)).toList(),
      productionCompanies: List.from(
        json['production_companies'],
      ).map((e) => ProductionCompanyModel.fromJson(e)).toList(),
    );
  }
}
