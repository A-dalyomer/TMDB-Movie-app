import 'package:equatable/equatable.dart';

import '../../data/model/genre_model.dart';
import 'production_company.dart';

class MovieDetails extends Equatable {
  final int id;
  final String title;
  final String posterImage;
  final String description;
  final DateTime dateTime;
  final List<GenreModel> genres;
  final List<ProductionCompany> productionCompanies;

  const MovieDetails({
    required this.id,
    required this.title,
    required this.posterImage,
    required this.description,
    required this.dateTime,
    required this.genres,
    required this.productionCompanies,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        posterImage,
        description,
        dateTime,
        genres.length,
        productionCompanies.length
      ];
}
