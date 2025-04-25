import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/features/home_screen/data/repositories/books_repo.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksCubit extends Cubit<BooksStates> {
  BooksCubit(this.booksRepo) : super(BooksInitialState());
  final BooksRepo booksRepo;
  static BooksCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;

  Future<void> getBooksList({int? page}) async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;

    emit(GetBooksLoadingState());
    final result = await booksRepo.getBooksList(page: page);
    result.fold((failure) {
      emit(GetBooksErrorState(failure.errMessage));
    }, (books) {
      setBooksList(books["data"]);
      emit(GetBooksSuccessState());
    });
    isLoading = false;
  }

  bool hasReachedMax = false;
  int? nextPage;
  List<Book> booksList = [];
  void setBooksList(books) {
    books["results"].forEach((book) {
      booksList.add(Book.fromJson(book));
    });
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
