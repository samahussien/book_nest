import 'package:flutter/material.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No favorite books yet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}