import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

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
          Text(
            'No favorite books yet\n Browse the library and add some!',
            textAlign: TextAlign.center,
            style:Styles.headlineStyle.copyWith(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}