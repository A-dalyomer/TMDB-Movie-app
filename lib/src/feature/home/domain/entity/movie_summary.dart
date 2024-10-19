import 'package:equatable/equatable.dart';

class MovieSummary extends Equatable {
  const MovieSummary({
    required this.id,
    required this.posterImage,
    required this.title,
    required this.rating,
  });
  final int id;
  final String posterImage;
  final String title;
  final double rating;

  @override
  List<Object?> get props => [id, posterImage, title, rating];
}
