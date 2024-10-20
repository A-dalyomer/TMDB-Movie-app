import 'package:flutter/material.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieSummary});
  final MovieSummary movieSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieSummary.title),
      ),
      body: Text(movieSummary.title),
    );
  }
}
