import 'package:flutter/material.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/entity/movie_summary.dart';

import '../../../../core/widget/poster_image_widget.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, required this.onTap});
  final MovieSummary movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            PosterImageWidget(
              path: movie.posterImage,
            ),
            Text(movie.title),
          ],
        ),
      ),
    );
  }
}
