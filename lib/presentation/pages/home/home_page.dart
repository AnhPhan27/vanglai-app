import 'package:flutter/material.dart';
import 'package:vanglai_app/presentation/pages/activity_hub/activity_hub_page.dart';
import 'package:vanglai_app/presentation/pages/post/post_page.dart';
import 'package:vanglai_app/presentation/pages/profile/profile.dart';
import '../../base/base_state.dart';
import '../../widgets/game_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/tab_selector.dart';
import '../../../data/model/game_match.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const ActivityHubTab(),
    const PostTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                isActive: _currentIndex == 0,
              ),
              _buildNavItem(
                icon: Icons.grid_view,
                label: 'Activity Hub',
                index: 1,
                isActive: _currentIndex == 1,
              ),
              _buildNavItem(
                icon: Icons.add_box,
                label: 'Post',
                index: 2,
                isActive: _currentIndex == 2,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                index: 3,
                isActive: _currentIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        safeSetState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: isActive ? AppColors.accent : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isActive ? AppColors.accent : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _selectedSport = 'badminton';

  // Sample data - replace with real data later
  final List<GameMatch> _sampleGames = [
    GameMatch(
      id: '1',
      locationName: 'City Courts, Westside',
      imageUrl:
          'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=800',
      dateTime: 'Tomorrow, 7:00 PM',
      skillLevel: 'Intermediate',
      currentPlayers: 2,
      maxPlayers: 6,
      price: 12.0,
      host: GameHost(
        id: '1',
        name: 'Sarah Lee',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        isVerified: true,
      ),
      isFull: false,
      sport: 'badminton',
    ),
    GameMatch(
      id: '2',
      locationName: 'Smash Arena, Downtown',
      imageUrl:
          'https://images.unsplash.com/photo-1553778263-73a83bab9b0c?w=800',
      dateTime: 'Today, 6:00 PM',
      skillLevel: 'Beginner',
      currentPlayers: 5,
      maxPlayers: 8,
      price: 10.0,
      host: GameHost(
        id: '2',
        name: 'Alex Johnson',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        isVerified: false,
      ),
      isFull: false,
      sport: 'badminton',
    ),
    GameMatch(
      id: '3',
      locationName: 'Northside Club',
      imageUrl:
          'https://images.unsplash.com/photo-1622163642998-1ea32b0bbc67?w=800',
      dateTime: 'Today, 8:00 PM',
      skillLevel: 'Advanced',
      currentPlayers: 4,
      maxPlayers: 4,
      price: 15.0,
      host: GameHost(
        id: '3',
        name: 'Mike Chen',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        isVerified: false,
      ),
      isFull: true,
      sport: 'badminton',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'VangLai',
        leading: AppBarIconButton(
          icon: Icons.notifications_outlined,
          showBadge: true,
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Notifications')));
          },
        ),
        actions: [
          AppBarIconButton(
            icon: Icons.filter_list,
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Filter')));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabSelector(
            items: const [
              TabSelectorItem(
                label: 'Badminton',
                value: 'badminton',
                icon: Icons.sports_tennis,
              ),
              TabSelectorItem(
                label: 'Pickleball',
                value: 'pickleball',
                icon: Icons.sports_baseball,
              ),
            ],
            selectedValue: _selectedSport,
            onChanged: (sport) {
              setState(() {
                _selectedSport = sport;
              });
            },
            selectedColor: AppColors.accent,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _sampleGames.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                return GameCard(
                  game: _sampleGames[index],
                  onJoinPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Joining ${_sampleGames[index].locationName}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
