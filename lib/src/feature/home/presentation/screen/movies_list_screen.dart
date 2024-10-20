import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/bloc/movies_home_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/widget/movie_item.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/app_localizations.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/locale_manager.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key, required this.movies});
  final List<MovieSummary> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleManager.tr(AppLocalizations.movies)),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 3,
        ),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieItem(
            movie: movie,
            onTap: () => context
                .read<MoviesHomeBloc>()
                .openMovieDetails(OpenMovieDetailsEvent(context, movie)),
          );
        },
      ),
    );
  }
}
