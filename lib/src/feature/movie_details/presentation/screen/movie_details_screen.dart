import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/di/di_manager.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/poster_image_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/repository/movie_details_repository.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/presentation/bloc/movie_details_bloc.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieSummary});
  final MovieSummary movieSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieSummary.title),
      ),
      body: BlocProvider(
        create: (context) => MovieDetailsBloc(
          DIManager.getIt<MovieDetailsRepository>(),
        )..add(LoadMovieDetailsEvent(movieId: movieSummary.id)),
        child: Builder(builder: (context) {
          void refresh() => context
              .read<MovieDetailsBloc>()
              .add(LoadMovieDetailsEvent(movieId: movieSummary.id));
          return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              switch (state) {
                case MovieDetailsInitial():
                  return const LoadingWidget();
                case MovieDetailsError():
                  return LoadingErrorWidget(refresh: refresh);
                case MovieDetailsDone():
                  return Column(
                    children: [
                      PosterImageWidget(path: state.movieDetails.posterImage),
                      Text(state.movieDetails.title),
                      Text(state.movieDetails.dateTime.toString()),
                      Wrap(
                        children: [
                          for (var genre in state.movieDetails.genres)
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(genre.name),
                              ),
                            )
                        ],
                      ),
                      Text(state.movieDetails.description),
                      Text(
                        state.movieDetails.productionCompanies
                            .map(
                              (e) => e.name,
                            )
                            .toList()
                            .fold(
                              '',
                              (previousValue, element) =>
                                  '$previousValue, $element',
                            ),
                      ),
                    ],
                  );
              }
            },
          );
        }),
      ),
    );
  }
}
