import 'dart:developer';

import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/features/home_screen/data/repositories/books_repo.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksCubit extends Cubit<BooksStates> {
  BooksCubit(this.booksRepo) : super(BooksInitialState());
  final BooksRepo booksRepo;
  static BooksCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;
  bool hasReachedMax = false;
  int? booknextPage;
  int? searchNextPage;
  List<Book> booksList = [];
  List<Book> searchBooksList = [];
  String? searchQuery = "";

  Future<void> getBooksList({int? page = 1}) async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;
// if (title != null && title.isNotEmpty) {
//       emit(SearchBookLoadingState());
//     } else {
    emit(GetBooksLoadingState());
    // }
    final result = await booksRepo.getBooksList(page: page);
    result.fold((failure) {
      emit(GetBooksErrorState(failure.errMessage));
    }, (books) {
      setBooksList(books: books["data"], page: page);
      emit(GetBooksSuccessState());
    });
    isLoading = false;
  }

  Future<void> searchBooks({required String title, int? page = 1}) async {
    if (isLoading || hasReachedMax) return;
    isLoading = true;
    emit(SearchBooksLoadingState());
    final result = await booksRepo.getBooksList(title: title, page: page);
    result.fold((failure) {
      emit(SearchBookErrorState(failure.errMessage));
    }, (books) {
      setSearchBooksList(books: books["data"], title: title, page: page);
      emit(SearchBookSuccessState(searchBooksList));
    });
    isLoading = false;
  }

  void setSearchBooksList({required dynamic books, String? title, int? page}) {
    {
      hasReachedMax = false;
      searchQuery = title;
      if (page == 1) {
        searchBooksList.clear();
      }
      books["results"].forEach((book) {
        searchBooksList.add(Book.fromJson(book));
      });
      log(books["results"].toString());
      emit(SetSearchBooksListState());
      _setNextPage(books, true);
    }
  }

  void setBooksList({required dynamic books, int? page}) {
    log(books.toString());
    // if (title != null && title.isNotEmpty) {
    //   searchQuery = title;
    //   if (page == 1) {
    //     searchBooksList.clear();
    //   }
    //   books["results"].forEach((book) {
    //     searchBooksList.add(Book.fromJson(book));
    //   });

    //   emit(SearchBookSuccessState(searchBooksList));
    // } else {
    books["results"].forEach((book) {
      booksList.add(Book.fromJson(book));
    });
    // }

    _setNextPage(books, false);
  }

  void clearSearch() {
    searchQuery = "";
    searchNextPage = null;
    searchBooksList.clear();
    hasReachedMax = false;
    // getBooksList(page: 1);
    emit(ClearSearchState());
  }

  void _setNextPage(books, bool isSearch) {
    String? nextUrl = books["next"];
    if (nextUrl != null) {
      Uri uri = Uri.parse(nextUrl);
      String? pageStr = uri.queryParameters['page'];

      int page = int.parse(pageStr!);
      hasReachedMax = false;
      isSearch ? searchNextPage = page : booknextPage = page;
      emit(NextPageState());
    } else {
      hasReachedMax = true;
      nextUrl = null;
      emit(HasReachedMaxState(hasReachedMax));
    }
  }
}
