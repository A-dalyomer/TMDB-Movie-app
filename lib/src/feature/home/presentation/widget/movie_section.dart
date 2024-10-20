import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/bloc/movies_home_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/widget/movie_item.dart';

class MovieSection extends StatelessWidget {
  const MovieSection({
    super.key,
    required this.title,
    required this.refresh,
    required this.movies,
  });
  final String title;
  final VoidCallback refresh;
  final List<MovieSummary>? movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        if (movies == null)
          LoadingErrorWidget(refresh: refresh)
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: movies!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MovieItem(
                    movie: movie,
                    onTap: () => context
                        .read<MoviesHomeBloc>()
                        .add(OpenMovieDetailsEvent(context, movie)),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
