import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/theme/app_text_styles.dart';
import '../../data/model/game_match.dart';
import 'badge_chip.dart';

class GameCard extends StatelessWidget {
  final GameMatch game;
  final VoidCallback? onJoinPressed;

  const GameCard({super.key, required this.game, this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImageSection(), _buildHostSection()],
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                image: DecorationImage(
                  image: NetworkImage(game.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: game.isFull
                      ? ColorFilter.mode(
                          Colors.grey.shade300,
                          BlendMode.saturation,
                        )
                      : null,
                ),
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0),
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.8),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Full Overlay (if game is full)
          if (game.isFull)
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Center(
                child: Transform.rotate(
                  angle: -0.2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'FULL',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Top Badges
          Positioned(
            top: 16,
            left: 16,
            right: 80,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SkillLevelBadge(skillLevel: game.skillLevel),
                SlotsBadge(
                  currentPlayers: game.currentPlayers,
                  maxPlayers: game.maxPlayers,
                ),
              ],
            ),
          ),

          // Price Tag
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: game.isFull ? AppColors.primary : AppColors.accent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '\$${game.price.toStringAsFixed(0)}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.locationName,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        game.dateTime,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          // Host Avatar
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(game.host.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (game.host.isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Host Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hosted by',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  game.host.name,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Join Button
          ElevatedButton(
            onPressed: game.isFull ? null : onJoinPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: game.isFull
                  ? AppColors.backgroundLight
                  : (game.currentPlayers >= game.maxPlayers * 0.7
                        ? AppColors.textPrimary
                        : AppColors.accent),
              foregroundColor: game.isFull
                  ? AppColors.textSecondary
                  : Colors.white,
              elevation: game.isFull ? 0 : 4,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: AppColors.backgroundLight,
              disabledForegroundColor: AppColors.textSecondary,
            ),
            child: Text(
              game.isFull ? 'Join Waitlist' : 'Join Game',
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: game.isFull ? AppColors.textSecondary : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
