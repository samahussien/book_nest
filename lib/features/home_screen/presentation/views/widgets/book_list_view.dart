import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_list_item.dart';
import 'package:book_nest/shared/custom_scroll_indicator.dart';
import 'package:flutter/material.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    super.key,
    required this.cubit,
    required this.booksList,
    required this.height,
  });

  final BooksCubit cubit;
  final List<Book> booksList;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == booksList.length) {
          return cubit.hasReachedMax
              ? SizedBox.shrink()
              : CustomScrollIndicator();
        }

        return BookListItem(book: booksList[index]);
      },
      separatorBuilder: (context, index) => SizedBox(
        height: height * 0.01,
      ),
      itemCount: booksList.length + 1,
      shrinkWrap: true,
    );
  }
}
