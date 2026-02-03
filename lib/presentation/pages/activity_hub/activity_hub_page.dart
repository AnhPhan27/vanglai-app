import 'package:flutter/material.dart';
import 'package:vanglai_app/common/theme/app_colors.dart';
import 'package:vanglai_app/presentation/widgets/custom_app_bar.dart';
import 'package:vanglai_app/presentation/widgets/tab_selector.dart';
import 'package:vanglai_app/presentation/widgets/activity_card.dart';

class ActivityHubTab extends StatefulWidget {
  const ActivityHubTab({super.key});

  @override
  State<ActivityHubTab> createState() => _ActivityHubTabState();
}

class _ActivityHubTabState extends State<ActivityHubTab> {
  String _selectedTab = 'playing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'Activity Hub',
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textPrimary,
            ),
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: TabSelector(
              items: const [
                TabSelectorItem(label: 'Playing', value: 'playing'),
                TabSelectorItem(label: 'Organizing', value: 'organizing'),
              ],
              selectedValue: _selectedTab,
              onChanged: (value) => setState(() => _selectedTab = value),
              selectedColor: AppColors.primary,
            ),
          ),

          // Activity List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ActivityCard(
                  title: 'Downtown Sports Center',
                  subtitle: 'Badminton • Court 2',
                  dateTime: 'Sat, Oct 24 • 10:00 AM - 12:00 PM',
                  icon: Icons.sports_tennis,
                  iconColor: AppColors.primary,
                  iconBackground: const Color(0xFFFFF7ED),
                  status: ActivityStatus.pending,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                ActivityCard(
                  title: 'City Park Court 3',
                  subtitle: 'Pickleball • Outdoor',
                  dateTime: 'Sun, Oct 25 • 04:00 PM - 06:00 PM',
                  icon: Icons.sports_handball,
                  iconColor: const Color(0xFF059669),
                  iconBackground: const Color(0xFFECFDF5),
                  status: ActivityStatus.approved,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                ActivityCard(
                  title: 'Riverside Arena',
                  subtitle: 'Badminton • Court 1',
                  dateTime: 'Tue, Oct 27 • 06:00 PM - 08:00 PM',
                  icon: Icons.sports_tennis,
                  iconColor: const Color(0xFF059669),
                  iconBackground: const Color(0xFFECFDF5),
                  status: ActivityStatus.approved,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                ActivityCard(
                  title: 'Community Hall',
                  subtitle: 'Pickleball • Indoor',
                  dateTime: 'Wed, Oct 28 • 07:00 PM',
                  icon: Icons.cancel,
                  iconColor: const Color(0xFFEF4444),
                  iconBackground: const Color(0xFFFEF2F2),
                  status: ActivityStatus.cancelled,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                // Find new match button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.border,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary10,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Find a new match',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
