import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';

enum ActivityStatus { pending, approved, cancelled }

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTime;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final ActivityStatus status;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCancelled = status == ActivityStatus.cancelled;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Opacity(
          opacity: isCancelled ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  // Title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            decoration: isCancelled
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Status badge
                  _buildStatusBadge(),
                ],
              ),
              const SizedBox(height: 12),
              // Date/Time
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _getDateIcon(),
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dateTime,
                        style: TextStyle(
                          fontSize: 14,
                          color: isCancelled
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case ActivityStatus.pending:
        bgColor = const Color(0xFFFED7AA);
        textColor = const Color(0xFF9A3412);
        label = 'Pending';
        break;
      case ActivityStatus.approved:
        bgColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF065F46);
        label = 'Approved';
        break;
      case ActivityStatus.cancelled:
        bgColor = const Color(0xFFF3F4F6);
        textColor = const Color(0xFF6B7280);
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  IconData _getDateIcon() {
    switch (status) {
      case ActivityStatus.pending:
        return Icons.calendar_today;
      case ActivityStatus.approved:
        return Icons.schedule;
      case ActivityStatus.cancelled:
        return Icons.event_busy;
    }
  }
}
