import 'dart:developer';

import 'package:book_nest/features/home_screen/data/cache_helper.dart';
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
  bool isOffline = false;

  //general books list
  Future<void> getBooksList({int? page = 1}) async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;
    isOffline = false;

    emit(GetBooksLoadingState());
    final result = await booksRepo.getBooksList(page: page);
    result.fold((failure) async {
      booksList = await CacheHelper.getBookList('books_list', cacheOffline);

      if (booksList.isNotEmpty) {
        emit(GetBooksSuccessState());
      } else {
        emit(GetBooksErrorState(failure.errMessage));
      }
    }, (books) async {
      setBooksList(books: books["data"], page: page);
      await CacheHelper.saveBookList('books_list', booksList); // Save to cache

      emit(GetBooksSuccessState());
    });
    isLoading = false;
  }

  void setBooksList({required dynamic books, int? page}) {
    log(books.toString());

    books.runtimeType == List
        ? books.forEach((book) {
            booksList.add(Book.fromJson(book));
          })
        : books["results"].forEach((book) {
            booksList.add(Book.fromJson(book));
          });

    _setNextPage(books, false);
  }

//search books list

  Future<void> searchBooks({required String title, int? page = 1}) async {
    if (isLoading || hasReachedMax) return;
    isLoading = true;
    isOffline = false;
    emit(SearchBooksLoadingState());
    final result = await booksRepo.getBooksList(title: title, page: page);
    result.fold((failure) async {
      searchBooksList =
          await CacheHelper.getBookList('search_list_$title', cacheOffline);

      if (searchBooksList.isNotEmpty) {
        emit(SearchBookSuccessState(searchBooksList));
      } else {
        emit(SearchBookErrorState(failure.errMessage));
      }
    }, (books) async {
      setSearchBooksList(books: books["data"], title: title, page: page);
      await CacheHelper.saveBookList('search_list_$title', searchBooksList);

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

  void clearSearch() {
    searchQuery = "";
    searchNextPage = null;
    searchBooksList.clear();
    hasReachedMax = false;
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

//favorites books list
  List<Book> favoriteBooksList = [];

  void getFavoriteBooks() async {
    favoriteBooksList = await CacheHelper.getFavoriteBooks();
    emit(GetFavoriteBooksState(booksList));
  }

  void addBookToFavorites({required Book book}) async {
    favoriteBooksList.add(book);
    await CacheHelper.addBookToFavorites(book);
    log(favoriteBooksList.toString());
    emit(SetFavoriteBooksState(booksList));
  }

  void removeBookFromFavorites({required Book book}) async {
    favoriteBooksList.remove(book);

    await CacheHelper.removeBookFromFavorites(book);
    log(favoriteBooksList.toString());
    emit((RemoveBookFromFavoritesState(favoriteBooksList)));
  }

  void clearFavoriteBooks() async {
    favoriteBooksList.clear();
    await CacheHelper.clearAllFavorites();
    emit(ClearAllFavoritesState());
  }

  //caching
  void cacheOffline() async {
    isOffline = true;

    emit(CheckOfflineState());
  }
}
