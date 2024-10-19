import 'movie_summary_model.dart';

class MoviesListModel {
  MoviesListModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  late final int page;
  late final List<MovieSummaryModel> results;
  late final int totalPages;
  late final int totalResults;

  MoviesListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results'])
        .map((e) => MovieSummaryModel.fromJson(e))
        .toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['page'] = page;
    data['results'] = results.map((e) => e.toJson()).toList();
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
