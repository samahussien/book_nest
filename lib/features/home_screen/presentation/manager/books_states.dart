import 'package:book_nest/features/home_screen/data/models/book/book.dart';

abstract class BooksStates {}

class BooksInitialState extends BooksStates {}

//general book list
class GetBooksLoadingState extends BooksStates {}

class GetBooksSuccessState extends BooksStates {}

class GetBooksErrorState extends BooksStates {
  final String error;
  GetBooksErrorState(this.error);
}

//search book list
class SearchBooksLoadingState extends BooksStates {}

class SearchBooksErrorState extends BooksStates {
  final String error;
  SearchBooksErrorState(this.error);
}

class SearchBookErrorState extends BooksStates {
  final String error;
  SearchBookErrorState(this.error);
}

class ClearSearchState extends BooksStates {}

class SearchBookSuccessState extends BooksStates {
  final List<Book> booksList;
  SearchBookSuccessState(this.booksList);
}

class SetSearchBooksListState extends BooksStates {}

//pagination states
class HasReachedMaxState extends BooksStates {
  final bool hasReachedMax;
  HasReachedMaxState(this.hasReachedMax);
}

class NextPageState extends BooksStates {}

//offline state
class CheckOfflineState extends BooksStates {}

//favorite books list
class GetFavoriteBooksState extends BooksStates {
  final List<Book> booksList;
  GetFavoriteBooksState(this.booksList);
}

class SetFavoriteBooksState extends BooksStates {
  final List<Book> booksList;
  SetFavoriteBooksState(this.booksList);
}

class RemoveBookFromFavoritesState extends BooksStates {
  final List<Book> booksList;
  RemoveBookFromFavoritesState(this.booksList);
}

class ClearAllFavoritesState extends BooksStates {}

class FavoriteBooksUpdatedState extends BooksStates {
  final List<Book> booksList;
  FavoriteBooksUpdatedState(this.booksList);
}
