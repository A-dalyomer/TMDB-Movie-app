import 'package:flutter/material.dart';
import 'package:tmdp_movie_app/src/feature/movie_details/domain/entity/genre.dart';

class MovieGenresWidget extends StatelessWidget {
  const MovieGenresWidget({super.key, required this.genres});
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var genre in genres)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  genre.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
