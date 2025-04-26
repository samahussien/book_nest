import 'package:book_nest/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepo {
  Future<Either<Failure,dynamic>> getBooksList({int? page, String? title});

}
