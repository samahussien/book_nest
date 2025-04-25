
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_list_item.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  const BookImage({
    super.key,
    required this.widget,
    required this.width,
    required this.height,
  });

  final BookListItem widget;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
       widget.book.formats!.imageJpeg?? '',
        width: width * 0.2,
        fit: BoxFit.contain,
        errorBuilder: (context, url, error) => SizedBox(
            width: width * 0.2,
            height: height * 0.18,
            child: Center(
                child: const Icon(
              Icons.error,
              color: AppColors.primary,
            ))),
      ),
    );
  }
}
