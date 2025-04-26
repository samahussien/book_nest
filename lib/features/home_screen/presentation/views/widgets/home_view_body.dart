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
 final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  FocusNode searchFocusNode = FocusNode();

  void _performSearch(String query) {
    FocusScope.of(context).unfocus();
    setState(() {
      searchQuery = query;
    });
    BlocProvider.of<BooksCubit>(context).getBooksList(title: query);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    BooksCubit cubit = BooksCubit.get(context);
    return BlocBuilder<BooksCubit, BooksStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSearchBar(
                  controller: _searchController,
                  focusNode: searchFocusNode,
                  onSubmit: _performSearch,
                  onchange: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        cubit.nextPage = null;
                      });
                    }
                    setState(() {
                      searchQuery = value;
                      _searchController.text = value;
                    });
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: cubit.searchQuery != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search results: ",
                            style: Styles.headlineStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  searchQuery = "";
                                  cubit.searchQuery = "";
                                  cubit.searchBooksList.clear();
                                });
                              },
                              icon: Icon(Icons.close))
                        ],
                      )
                    : Text(
                        "Nothing on your mind? our bookshelf is full of books to read",
                        style: Styles.headlineStyle,
                      ),
              ),
              (state is GetBooksLoadingState ||
                          state is SearchBookLoadingState) &&
                      (cubit.nextPage == null||cubit.nextPage==2)
                  ? Expanded(child: CustomScrollIndicator())
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
                              cubit.getBooksList(
                                page: cubit.nextPage,
                                title: cubit.searchQuery,
                              );
                              _isDebouncing = false;
                            });
                          }
                          return false;
                        },
                        child: BookListView(
                          cubit: cubit,
                          height: height,
                          booksList: cubit.searchBooksList.isNotEmpty
                              ? cubit.searchBooksList
                              : cubit.booksList,
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
