import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PhotoFrame extends StatelessWidget {
  const PhotoFrame({
    super.key,
    required this.asset,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String asset;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);
    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        asset,
        height: height,
        width: width ?? double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width ?? double.infinity,
            color: AppColors.cream,
            alignment: Alignment.center,
            child: const Icon(Icons.image_outlined, color: AppColors.moss, size: 32),
          );
        },
      ),
    );
  }
}
