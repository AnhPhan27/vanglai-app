import 'package:flutter/material.dart';
import 'package:vanglai_app/common/theme/app_text_styles.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 16),
          Text('User Profile', style: AppTextStyles.headlineSmall),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Handle logout
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
