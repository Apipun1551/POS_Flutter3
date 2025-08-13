import 'package:flutter/material.dart';
import 'package:fic23pos_flutter/core/components/search_input.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/date_time_ext.dart';



class HomeTitle extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;

  const HomeTitle({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Disha Parfumery',
              style: TextStyle(
                color: AppColors.brand,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              DateTime.now().toFormattedDate(),
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 300.0,
          child: SearchInput(
            controller: controller,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
