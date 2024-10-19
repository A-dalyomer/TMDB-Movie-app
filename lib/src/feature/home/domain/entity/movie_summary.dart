import 'package:equatable/equatable.dart';

class MovieSummary extends Equatable {
  const MovieSummary({
    required this.posterImage,
    required this.title,
    required this.rating,
  });
  final String posterImage;
  final String title;
  final double rating;

  @override
  List<Object?> get props => [posterImage, title, rating];
}
