import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/poster_image_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/repository/movie_details_repository.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/presentation/bloc/movie_details_bloc.dart';

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
                        SizedBox(
                          height: 200,
                          child: CarouselView(
                            itemExtent: MediaQuery.sizeOf(context).width * 0.7,
                            onTap: (index) =>
                                context.read<MovieDetailsBloc>().add(
                                      OpenMovieTrailerEvent(
                                        movieKey: state.movieVideoKeys[index],
                                      ),
                                    ),
                            children: [
                              for (var _ in state.movieVideoKeys)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                )
                            ],
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
