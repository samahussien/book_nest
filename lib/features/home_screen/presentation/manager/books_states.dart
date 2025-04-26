
import 'package:book_nest/features/home_screen/data/models/book/book.dart';

abstract class BooksStates {}

class BooksInitialState extends BooksStates {}

class GetBooksLoadingState extends BooksStates {}

class GetBooksSuccessState extends BooksStates {}

class GetBooksErrorState extends BooksStates {
  final String error;
  GetBooksErrorState(this.error);
}

class SearchBooksLoadingState extends BooksStates {}

class SearchBooksSuccessState extends BooksStates {
  final List<Book> booksList;
  SearchBooksSuccessState(this.booksList);
}

class SearchBooksErrorState extends BooksStates {
  final String error;
  SearchBooksErrorState(this.error);
}



class HasReachedMaxState extends BooksStates {
  final bool hasReachedMax;
  HasReachedMaxState(this.hasReachedMax);
}

class NextPageState extends BooksStates {
  
}


class SearchBookSuccessState extends BooksStates {
  final List<Book> booksList;
  SearchBookSuccessState(this.booksList);
}
class SetSearchBooksListState extends BooksStates {

}

class SearchBookErrorState extends BooksStates {
  final String error;
  SearchBookErrorState(this.error);
}
class ClearSearchState extends BooksStates {

}