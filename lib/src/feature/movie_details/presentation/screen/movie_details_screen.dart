import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/poster_image_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/repository/movie_details_repository.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/presentation/widget/movie_genres_widget.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/presentation/widget/movie_trailers_carousel.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movieSummary,
    required this.movieDetailsRepository,
  });
  final MovieSummary movieSummary;
  final MovieDetailsRepository movieDetailsRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieSummary.title),
      ),
      body: BlocProvider<MovieDetailsBloc>(
        create: (context) => MovieDetailsBloc(movieDetailsRepository)
          ..add(LoadMovieDetailsEvent(movieId: movieSummary.id)),
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
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        PosterImageWidget(
                          path: state.movieDetails.posterImage,
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          width: 2000,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          state.movieDetails.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          state.movieDetails.dateTime
                              .toString()
                              .split(' ')
                              .first,
                        ),
                        MovieGenresWidget(genres: state.movieDetails.genres),
                        Text(
                          state.movieDetails.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          state.movieDetails.productionCompanies
                              .map((e) => e.name)
                              .toList()
                              .fold(
                                'Productions',
                                (previousValue, element) =>
                                    '$previousValue, $element',
                              ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 200,
                          child: MovieTrailersCarousel(
                            movieVideoKeys: state.movieVideoKeys,
                          ),
                        )
                      ],
                    ),
                  );
              }
            },
          );
        }),
      ),
    );
  }
}
