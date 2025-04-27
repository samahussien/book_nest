import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
    this.focusNode,
 required   this.controller,
    this.onchange,
    this.onSubmit,
  });
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onchange;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: () {
        controller.text = controller.text.trimRight();
      },
      controller: controller,
      onChanged: onchange,
      focusNode: focusNode,
      onSubmitted: onSubmit,
      textInputAction: TextInputAction.search,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "Search for books",
        hintStyle: Styles.hintStyle,
             suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        controller.clear();
                        BlocProvider.of<BooksCubit>(context).searchQuery = "";
                                   BlocProvider.of<BooksCubit>(context).searchNextPage = null;
                                    BlocProvider.of<BooksCubit>(context).hasReachedMax = false;
                      },
                    )
                  : null,
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.secondary,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary), // Default border
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary), // Default border
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
