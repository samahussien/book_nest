import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_states.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_list_item.dart';
import 'package:book_nest/shared/warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    BooksCubit cubit = BooksCubit.get(context);
    return BlocBuilder<BooksCubit, BooksStates>(builder: (context, state) {
      return    Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child:cubit.favoriteBooksList.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                
                return BookListItem(
                    key: ValueKey(cubit.favoriteBooksList[index].id),

                    book:cubit.favoriteBooksList[index]);
              },
              separatorBuilder: (context, index) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              itemCount:
                 cubit.favoriteBooksList.length,
            )
          
          : const Warning(
              message:
                  'No favorite books yet\n Browse the library and add some!'),
      );
   
    });
  
  }
}
