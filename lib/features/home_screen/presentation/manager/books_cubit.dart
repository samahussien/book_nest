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
  int? nextPage;
  List<Book> booksList = [];
  List<Book> searchBooksList = [];
  String? searchQuery = "";


  Future<void> getBooksList({int? page = 1, String? title}) async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;
if (title != null && title.isNotEmpty) {
      emit(SearchBookLoadingState());
    } else {
      emit(GetBooksLoadingState());
    }
    final result = await booksRepo.getBooksList(page: page, title: title);
    result.fold((failure) {
      emit(GetBooksErrorState(failure.errMessage));
    }, (books) {
      setBooksList(books: books["data"], title: title,page: page);
      emit(GetBooksSuccessState());
    });
    isLoading = false;
  }




  void setBooksList({required dynamic books, String? title, int? page}) {
    log(books.toString());
    if (title != null && title.isNotEmpty) {
      searchQuery = title;
      if (page == 1) {
        searchBooksList.clear();
      }
      books["results"].forEach((book) {
        searchBooksList.add(Book.fromJson(book));
      });

      emit(SearchBookSuccessState(searchBooksList));
    } else {
      books["results"].forEach((book) {
        booksList.add(Book.fromJson(book));
      });
    }

    _setNextPage(books);
  }

  void _setNextPage(books) {
    String? nextUrl = books["next"];
    if (nextUrl != null) {
      Uri uri = Uri.parse(nextUrl);
      String? pageStr = uri.queryParameters['page'];
      
      int page = int.parse(pageStr!);
      hasReachedMax = false;
      nextPage = page;
      emit(NextPageState(nextPage));
    } else {
      hasReachedMax = true;
      nextUrl = null;
      emit(HasReachedMaxState(hasReachedMax));
    }
  }
}
