
import 'package:book_nest/core/errors/failure.dart';
import 'package:book_nest/features/home_screen/data/repositories/books_repo.dart';
import 'package:book_nest/features/home_screen/data/services/api_paths.dart';
import 'package:book_nest/features/home_screen/data/services/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BooksRepoImpl implements BooksRepo {
  ApiService apiService;
  BooksRepoImpl(this.apiService);
  @override
   Future<Either<Failure,dynamic>> getBooksList({int? page=1}) async {
    try{
    final Response response = await apiService.get(endPoint: ApiPaths.books,queryParameters: {
      "page": page,
    });

    return right({
      'code': response.statusCode,
      'data': response.data
    });
    }
    catch (e) {
      if (e is DioException) return left(ServerFailure.fromDioError(e));
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }

  }
}
