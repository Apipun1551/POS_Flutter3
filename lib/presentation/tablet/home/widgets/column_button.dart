// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';


class ColumnButton extends StatelessWidget {
  final String label;
  final SvgGenImage svgGenImage;
  final VoidCallback onPressed;
  final bool isActive;

  const ColumnButton({
    super.key,
    required this.label,
    required this.svgGenImage,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: isActive
                    ? Color.fromARGB(255, 208, 123, 137)
                    : AppColors.grey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: svgGenImage.svg(),
          ),
          const SpaceHeight(8.0),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? Color.fromARGB(255, 208, 123, 137)
                  : AppColors.grey.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
