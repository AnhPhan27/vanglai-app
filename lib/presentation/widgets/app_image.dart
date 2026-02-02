import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanglai_app/common/utils/app_utils.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;
  final Widget? defaultImage;

  const AppImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
    this.defaultImage,
  });

  @override
  Widget build(BuildContext context) {
    var imageProxy = '';
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (imageUrl.isEmpty) {
      return defaultImage ?? const SizedBox();
    }

    if (!imageUrl.contains('http')) {
      if (isSvgImage) {
        return SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(
                  AppUtils.getMaterialColor(color!),
                  BlendMode.srcIn,
                )
              : null,
          package: package,
        );
      }
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        package: package,
      );
    }

    if (isSvgImage) {
      return SvgPicture.network(
        '$imageProxy$imageUrl',
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter: color != null
            ? ColorFilter.mode(
                AppUtils.getMaterialColor(color!),
                BlendMode.srcIn,
              )
            : null,
      );
    }

    return ExtendedImage.network(
      '$imageProxy$imageUrl',
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.loading:
          case LoadState.failed:
            return defaultImage ?? const SizedBox();
        }
      },
    );
  }
}
