import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
    this.focusNode,
    this.controller,
    this.onchange,
    this.onSubmit,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onchange;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: () {
        controller?.text = controller!.text.trimRight();
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
