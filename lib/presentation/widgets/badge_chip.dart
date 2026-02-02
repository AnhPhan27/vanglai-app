import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/theme/app_text_styles.dart';

class BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? backgroundColor;
  final Color? textColor;

  const BadgeChip({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillLevelBadge extends StatelessWidget {
  final String skillLevel;

  const SkillLevelBadge({super.key, required this.skillLevel});

  Color _getIconColor() {
    switch (skillLevel.toLowerCase()) {
      case 'beginner':
        return AppColors.primary;
      case 'intermediate':
        return AppColors.accent;
      case 'advanced':
        return Colors.purple;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BadgeChip(
      icon: Icons.signal_cellular_alt,
      label: skillLevel,
      iconColor: _getIconColor(),
    );
  }
}

class SlotsBadge extends StatelessWidget {
  final int currentPlayers;
  final int maxPlayers;

  const SlotsBadge({
    super.key,
    required this.currentPlayers,
    required this.maxPlayers,
  });

  Color _getIconColor() {
    if (currentPlayers >= maxPlayers) {
      return Colors.red;
    } else if (currentPlayers >= maxPlayers * 0.7) {
      return Colors.yellow.shade600;
    }
    return Colors.green.shade400;
  }

  Color? _getBackgroundColor() {
    if (currentPlayers >= maxPlayers) {
      return const Color.fromRGBO(244, 67, 54, 0.9);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BadgeChip(
      icon: currentPlayers >= maxPlayers ? Icons.lock : Icons.group,
      label: '$currentPlayers/$maxPlayers Slots',
      iconColor: _getIconColor(),
      backgroundColor: _getBackgroundColor(),
    );
  }
}
