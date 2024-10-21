import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_error_widget.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_widget.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/repository/movies_repository.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/util/enum.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/bloc/movies_home_bloc.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/widget/movie_section.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/app_localizations.dart';
import 'package:tmdp_movie_app/src/feature/localization/domain/util/locale_manager.dart';
import 'package:tmdp_movie_app/src/feature/theme/presentation/widget/toggle_theme_button.dart';

class MoviesHomeScreen extends StatelessWidget {
  const MoviesHomeScreen({super.key, required this.moviesRepository});
  final MoviesRepository moviesRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstConfig.appName),
        actions: const [ToggleThemeButton()],
      ),
      body: BlocProvider(
        create: (context) =>
            MoviesHomeBloc(moviesRepository)..add(RefreshMoviesEvent()),
        child: Builder(builder: (context) {
          refreshMovies() async {
            final moviesBloc = context.read<MoviesHomeBloc>();
            Future future = moviesBloc.stream.first;
            moviesBloc.add(RefreshMoviesEvent());
            await future;
          }

          openMoviesList(MovieType type, List<MovieSummary>? movies) => context
              .read<MoviesHomeBloc>()
              .add(OpenMoviesListEvent(context, type, movies!));
          return RefreshIndicator(
            onRefresh: () async => await refreshMovies(),
            child: BlocBuilder<MoviesHomeBloc, MoviesHomeState>(
              builder: (context, state) {
                switch (state) {
                  case MoviesHomeInitial _:
                    return const LoadingWidget();
                  case MoviesHomeError _:
                    return LoadingErrorWidget(refresh: refreshMovies);
                  case MoviesHomeDone():
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieSection(
                            title:
                                LocaleManager.tr(AppLocalizations.nowPlaying),
                            refresh: refreshMovies,
                            onShowMore: () => openMoviesList(
                              MovieType.nowPlaying,
                              state.nowPlayingMovies,
                            ),
                            movies: state.nowPlayingMovies,
                          ),
                          MovieSection(
                            title: LocaleManager.tr(AppLocalizations.popular),
                            refresh: refreshMovies,
                            onShowMore: () => openMoviesList(
                              MovieType.popular,
                              state.popularMovies,
                            ),
                            movies: state.popularMovies,
                          ),
                          MovieSection(
                            title: LocaleManager.tr(AppLocalizations.topRated),
                            refresh: refreshMovies,
                            onShowMore: () => openMoviesList(
                              MovieType.topRated,
                              state.topRatedMovies,
                            ),
                            movies: state.topRatedMovies,
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
