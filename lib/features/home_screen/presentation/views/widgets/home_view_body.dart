
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_states.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_list_view.dart';
import 'package:book_nest/shared/custom_scroll_indicator.dart';
import 'package:book_nest/shared/custom_search_bar.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool _isDebouncing = false;

  @override
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    BooksCubit cubit = BooksCubit.get(context);
    return BlocBuilder<BooksCubit, BooksStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSearchBar(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Text(
                  "Nothing on your mind? our bookshelf is full of books to read",
                  style: Styles.headlineStyle,
                ),
              ),
              state is GetBooksLoadingState && cubit.nextPage == null
                  ? Expanded(
                      child: CustomScrollIndicator())
                  : Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification:
                            (ScrollNotification scrollNotification) {
                          if (!_isDebouncing &&
                              !cubit.hasReachedMax &&
                              !cubit.isLoading &&
                              scrollNotification.metrics.pixels ==
                                  scrollNotification.metrics.maxScrollExtent) {
                            _isDebouncing = true;

                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              cubit.getBooksList(page: cubit.nextPage);
                              _isDebouncing = false;
                            });
                          }
                          return false;
                        },
                        child: BookListView(cubit: cubit, height: height),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}



