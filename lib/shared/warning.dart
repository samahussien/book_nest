
import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  const Warning({
    super.key, required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 50,
            color: AppColors.secondary,
          ),
          Text(message,
              textAlign: TextAlign.center,
              style: Styles.headlineStyle.copyWith(color: AppColors.secondary)),
        ],
      ),
    );
  }
}
