import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool enabled;
  final int? maxLines;
  final TextStyle? style;
  final Color? fillColor;
  final Color? labelColor;
  final Color? iconColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.maxLines = 1,
    this.style,
    this.fillColor,
    this.labelColor,
    this.iconColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? const TextStyle(color: Colors.white);
    final defaultLabelColor =
        labelColor ?? const Color.fromRGBO(255, 255, 255, 179); // 0.7 opacity
    final defaultIconColor =
        iconColor ?? const Color.fromRGBO(255, 255, 255, 179); // 0.7 opacity
    final defaultFillColor =
        fillColor ?? const Color.fromRGBO(255, 255, 255, 26); // 0.1 opacity
    final defaultFocusedBorderColor = focusedBorderColor ?? AppColors.primary;
    final defaultEnabledBorderColor =
        enabledBorderColor ??
        const Color.fromRGBO(255, 255, 255, 77); // 0.3 opacity

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      maxLines: maxLines,
      style: defaultStyle,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: defaultLabelColor),
        hintStyle: TextStyle(color: defaultLabelColor),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: defaultIconColor)
            : null,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: defaultEnabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: defaultFocusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: defaultFillColor,
      ),
    );
  }
}
