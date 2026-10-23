import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LeafMark extends StatelessWidget {
  const LeafMark({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(size * 0.36),
        boxShadow: AppColors.softShadow,
      ),
      child: Icon(Icons.spa, color: AppColors.forest, size: size * 0.52),
    );
  }
}
