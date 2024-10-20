import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';
import 'package:tmdp_movie_app/src/core/widget/loading_widget.dart';

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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 3)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          placeholder: (context, url) => const LoadingWidget(),
          imageUrl: ConstConfig.imagesBase(path),
          fit: fit,
        ),
      ),
    );
  }
}
