import 'package:book_nest/features/favorites/presentation/views/widgets/favorite_view_body.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FavoriteViewBody(),
        floatingActionButton: FloatingActionButton(backgroundColor: AppColors.secondary, shape: CircleBorder(),onPressed: () {
          BlocProvider.of<BooksCubit>(context).clearFavoriteBooks();
        },child: Icon(Icons.delete,color: AppColors.accent,),));
  }
}
