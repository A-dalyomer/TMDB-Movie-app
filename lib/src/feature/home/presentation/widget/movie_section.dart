import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/bloc/movies_home_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/widget/movie_item.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/app_localizations.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/locale_manager.dart';

class MovieSection extends StatelessWidget {
  const MovieSection({
    super.key,
    required this.title,
    required this.refresh,
    required this.onShowMore,
    required this.movies,
  });
  final String title;
  final VoidCallback refresh;
  final VoidCallback onShowMore;
  final List<MovieSummary>? movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (movies != null)
                TextButton(
                  onPressed: onShowMore,
                  child: Text(LocaleManager.tr(AppLocalizations.showMore)),
                )
            ],
          ),
        ),
        if (movies == null)
          LoadingErrorWidget(refresh: refresh)
        else
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.28,
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
