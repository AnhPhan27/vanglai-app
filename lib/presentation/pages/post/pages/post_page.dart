import 'package:flutter/material.dart';
import 'package:vanglai_app/common/theme/app_colors.dart';
import 'package:vanglai_app/common/utils/validators.dart';
import 'package:vanglai_app/presentation/widgets/app_button.dart';
import 'package:vanglai_app/presentation/widgets/app_text_field.dart';
import 'package:vanglai_app/presentation/widgets/tab_selector.dart';
import 'package:vanglai_app/presentation/pages/post/widgets/media_upload_card.dart';
import 'package:vanglai_app/presentation/widgets/custom_app_bar.dart';
import 'package:vanglai_app/presentation/widgets/tap_outside_to_unfocus.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedSport = 'badminton';
  String? _selectedSkillLevel;
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _locationController.clear();
    _priceController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedSport = 'badminton';
      _selectedSkillLevel = null;
      _selectedDateTime = null;
    });
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null && mounted) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _postMatch() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Match posted successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'Host New Match',
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _resetForm,
            child: const Text(
              'Reset',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TapOutsideToUnfocus(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sport Selector
                TabSelector(
                  items: const [
                    TabSelectorItem(label: 'Badminton', value: 'badminton'),
                    TabSelectorItem(label: 'Pickleball', value: 'pickleball'),
                  ],
                  selectedValue: _selectedSport,
                  onChanged: (value) => setState(() => _selectedSport = value),
                  selectedColor: AppColors.primary,
                ),

                // Media Upload
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: MediaUploadCard(onTap: () {}),
                ),

                // Form Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Title
                      const Text(
                        'Match Title',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: _titleController,
                        hintText: 'e.g., Sunday Morning Smash',
                        validator: (value) => Validators.validateRequired(
                          value,
                          fieldName: 'Match title',
                        ),
                        fillColor: AppColors.surface,
                        labelColor: AppColors.textSecondary,
                        iconColor: AppColors.textSecondary,
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: AppColors.primary,
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 20),

                      // Date & Time
                      const Text(
                        'When?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selectDateTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.black10,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDateTime != null
                                      ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} at ${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}'
                                      : 'Select date and time',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedDateTime != null
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Location
                      const Text(
                        'Where?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: _locationController,
                        hintText: 'Search for a court or location',
                        suffixIcon: const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                        ),
                        validator: (value) => Validators.validateRequired(
                          value,
                          fieldName: 'Location',
                        ),
                        fillColor: AppColors.surface,
                        labelColor: AppColors.textSecondary,
                        iconColor: AppColors.textSecondary,
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: AppColors.primary,
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 20),

                      // Price and Skill Level
                      Row(
                        children: [
                          // Price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Cost / Person',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AppTextField(
                                  controller: _priceController,
                                  hintText: '0.00',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.attach_money,
                                  fillColor: AppColors.surface,
                                  labelColor: AppColors.textSecondary,
                                  iconColor: AppColors.textSecondary,
                                  enabledBorderColor: Colors.transparent,
                                  focusedBorderColor: AppColors.primary,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Skill Level
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Skill Level',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.black10,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSkillLevel,
                                      hint: const Text(
                                        'Select',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      isExpanded: true,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColors.primary,
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'beginner',
                                          child: Text('Beginner'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'intermediate',
                                          child: Text('Intermediate'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'advanced',
                                          child: Text('Advanced'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'pro',
                                          child: Text('Pro'),
                                        ),
                                      ],
                                      onChanged: (value) => setState(
                                        () => _selectedSkillLevel = value,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '(Optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: _descriptionController,
                        hintText: 'Add any specific rules or details...',
                        maxLines: 3,
                        fillColor: AppColors.surface,
                        labelColor: AppColors.textSecondary,
                        iconColor: AppColors.textSecondary,
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: AppColors.primary,
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          border: Border(
                            top: BorderSide(color: AppColors.border, width: 1),
                          ),
                        ),
                        child: SafeArea(
                          child: AppButton(
                            text: 'Post Match',
                            onPressed: _postMatch,
                            icon: Icons.arrow_forward,
                            backgroundColor: AppColors.primary,
                            isFullWidth: true,
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
      ),
    );
  }
}
