
import 'package:book_nest/features/favorites/presentation/views/favorite_view.dart';
import 'package:book_nest/features/home_screen/data/repositories/books_repo.dart';
import 'package:book_nest/features/home_screen/data/repositories/books_repo_impl.dart';
import 'package:book_nest/features/home_screen/data/services/api_service.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_states.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/home_view_body.dart';
import 'package:book_nest/shared/custom_app_bar.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
 const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
    int selectedIndex = 0;
    List<Widget> pages = [HomeViewBody(),FavoriteView()];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  final BooksRepo booksRepo = BooksRepoImpl(ApiService(Dio()));

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<BooksCubit, BooksStates>(
      builder: (context, state) => Scaffold(
        appBar: customAppBar(width),
        body: pages[selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          
          ],
          currentIndex: selectedIndex,

        ),
      ),
    );
  }


}
