import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';

class PosterImageWidget extends StatelessWidget {
  const PosterImageWidget({
    super.key,
    required this.path,
    this.fit,
    this.width,
    this.height,
  });
  final String path;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ConstConfig.imagesBase(path),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
