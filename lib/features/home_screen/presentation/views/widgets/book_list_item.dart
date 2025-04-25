import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_data.dart';
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_image.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatefulWidget {
  const BookListItem({super.key,required this.book});
 final Book book;
  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookImage(widget: widget, width: width, height: height),
            SizedBox(width: width * 0.05),
            Expanded(
              child:  BookData(widget: widget, width: width, height: height,)   ),
          ],
        ),
      ),
    );
  }
}