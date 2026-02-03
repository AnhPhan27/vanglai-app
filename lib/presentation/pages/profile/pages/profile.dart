import 'package:flutter/material.dart';
import 'package:vanglai_app/common/theme/app_colors.dart';
import 'package:vanglai_app/common/theme/app_text_styles.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stat_card.dart';
import '../widgets/profile_activity_item.dart';
import '../../setting/page/settings_page.dart';

/// Profile Tab - Used in the main navigation
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 250, 251, 0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: const ProfileContent(),
    );
  }
}

/// Reusable Profile Content Widget
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Header
          const ProfileHeader(
            name: 'Kevin Nguyen',
            memberSince: 'Member since Aug 2023',
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBPEtQLR5jWxYkTnj19mQ2PuiZIAxm0TFqb4Y02ffSU3AQUTW3DkaOpL664X9W62LRlIPbo3MjQbXyrXrHghXs-YC9SE8SQK8hKq167iSHwN8Z9pW0_A5iRdjfzHjTVJbEacRwd8XhYnp5Blc4T96vF2WXXOyLPegWImONKvgWFBfAnZN6Gc2XG4HG-aTV5HOUpJPGHqoMGG9b0n6O18yQZ3lYGNW8WERpUZmrp3G4WDPB3dGDLzGIoj7NpJN5WGNUn8_3rTeaBe8g',
          ),

          // Stats Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ProfileStatCard(label: 'Matches', value: '42'),
                SizedBox(width: 12),
                ProfileStatCard(label: 'Groups', value: '12'),
                SizedBox(width: 12),
                ProfileStatCard(label: 'Reputation', value: '4.9'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recent Activities',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Activity List
              ProfileActivityItem(
                icon: Icons.sports_tennis,
                title: 'Completed Badminton match',
                subtitle: 'District 7 • 2 hours ago',
                onTap: () {
                  // Handle activity tap
                },
              ),
              ProfileActivityItem(
                icon: Icons.group,
                title: 'Joined \'Elite Runners\' group',
                subtitle: 'Ho Chi Minh City • Yesterday',
                onTap: () {
                  // Handle activity tap
                },
              ),
              ProfileActivityItem(
                icon: Icons.workspace_premium,
                title: 'Earned \'Frequent Player\' badge',
                subtitle: 'Achievement • 3 days ago',
                onTap: () {
                  // Handle activity tap
                },
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
