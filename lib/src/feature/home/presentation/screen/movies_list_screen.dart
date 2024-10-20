import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/util/enum.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/bloc/movies_home_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/widget/movie_item.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/locale_manager.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({
    super.key,
    required this.movies,
    required this.movieType,
    required this.moviesHomeBloc,
  });
  final List<MovieSummary> movies;
  final MovieType movieType;
  final MoviesHomeBloc moviesHomeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesHomeBloc>.value(
      value: moviesHomeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleManager.tr(movieType.name)),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: MediaQuery.sizeOf(context).height * 0.25,
            crossAxisSpacing: 12,
            mainAxisSpacing: 6,
          ),
          itemCount: movies.length,
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
      ),
    );
  }
}
