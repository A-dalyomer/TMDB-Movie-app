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
      width: MediaQuery.sizeOf(context).width * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            PosterImageWidget(
              path: movie.posterImage,
              fit: BoxFit.fill,
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: double.infinity,
            ),
            Flexible(
              child: Text(
                movie.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
