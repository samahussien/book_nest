import 'package:book_nest/features/favorites/presentation/views/widgets/favorite_view_body.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FavoriteViewBody(),);
  }
}