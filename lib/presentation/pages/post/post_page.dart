import 'package:flutter/material.dart';
import 'package:vanglai_app/common/theme/app_colors.dart';
import 'package:vanglai_app/common/theme/app_text_styles.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_box, size: 100, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text('Create Post', style: AppTextStyles.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
