import 'movie_summary_model.dart';

class MoviesListModel {
  MoviesListModel({
    required this.page,
    required this.results,
  });
  late final int page;
  late final List<MovieSummaryModel> results;

  MoviesListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results'])
        .map((e) => MovieSummaryModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['page'] = page;
    data['results'] = results.map((e) => e.toJson()).toList();
    return data;
  }
}
