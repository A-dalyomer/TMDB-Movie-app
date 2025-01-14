import '../../domain/entity/movie_summary.dart';

class MovieSummaryModel extends MovieSummary {
  const MovieSummaryModel({
    required super.id,
    required super.posterImage,
    required super.title,
    required super.rating,
  });
  factory MovieSummaryModel.fromJson(Map<String, dynamic> json) {
    return MovieSummaryModel(
      id: json["id"],
      posterImage: json['poster_path'] ?? '',
      title: json['original_title'] ?? 'No title',
      rating: json['vote_average'] ?? 0,
    );
  }

  factory MovieSummaryModel.fromEntity(MovieSummary movie) {
    return MovieSummaryModel(
      id: movie.id,
      posterImage: movie.posterImage,
      title: movie.title,
      rating: movie.rating,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['poster_path'] = posterImage;
    data['original_title'] = title;
    data['vote_average'] = rating;
    return data;
  }
}
