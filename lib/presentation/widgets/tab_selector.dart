import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/theme/app_text_styles.dart';

class TabSelectorItem {
  final String label;
  final IconData? icon;
  final String value;

  const TabSelectorItem({required this.label, required this.value, this.icon});
}

class TabSelector extends StatelessWidget {
  final List<TabSelectorItem> items;
  final String selectedValue;
  final Function(String) onChanged;
  final Color selectedColor;
  final EdgeInsets? padding;

  const TabSelector({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = AppColors.accent,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.tabUnselected,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: items.map((item) {
            return Expanded(
              child: _buildTab(
                label: item.label,
                icon: item.icon,
                value: item.value,
                isSelected: selectedValue == item.value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required String value,
    required bool isSelected,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20,
                color: isSelected ? selectedColor : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                label,
                style: AppTextStyles.titleSmall.copyWith(
                  color: isSelected ? selectedColor : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
