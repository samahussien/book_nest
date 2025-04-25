
abstract class BooksStates {}

class BooksInitialState extends BooksStates {}

class GetBooksLoadingState extends BooksStates {}

class GetBooksSuccessState extends BooksStates {}

class GetBooksErrorState extends BooksStates {
  final String error;
  GetBooksErrorState(this.error);
}

class HasReachedMaxState extends BooksStates {
  final bool hasReachedMax;
  HasReachedMaxState(this.hasReachedMax);
}

class NextPageState extends BooksStates {
  final int? nextPage;
  NextPageState(this.nextPage);
}
