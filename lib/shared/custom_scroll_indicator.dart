import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomScrollIndicator extends StatelessWidget {
  const CustomScrollIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
