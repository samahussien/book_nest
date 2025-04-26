import 'package:book_nest/features/home_screen/data/repositories/books_repo_impl.dart';
import 'package:book_nest/features/home_screen/data/services/api_service.dart';
import 'package:book_nest/features/home_screen/presentation/manager/bloc_observer.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/utils/app_routes.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
   Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
         create: (context) => BooksCubit(BooksRepoImpl(ApiService(Dio())))
        ..getBooksList(),
      child: MaterialApp.router(
        title: 'book nest',
        theme: ThemeData(
          fontFamily: "Raleway",
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
//2368