import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_details_bloc.dart';

class MovieTrailersCarousel extends StatelessWidget {
  const MovieTrailersCarousel({super.key, required this.movieVideoKeys});
  final List<String> movieVideoKeys;

  @override
  Widget build(BuildContext context) {
    return CarouselView(
      itemExtent: MediaQuery.sizeOf(context).width * 0.7,
      onTap: (index) => context.read<MovieDetailsBloc>().add(
            OpenMovieTrailerEvent(
              movieKey: movieVideoKeys[index],
            ),
          ),
      children: [
        for (var _ in movieVideoKeys)
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
    );
  }
}
