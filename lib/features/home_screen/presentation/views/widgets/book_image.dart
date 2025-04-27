
import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  const BookImage({
    super.key,
    required this.book,
    required this.width,
    required this.height,
  });

  final Book book;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl:  book.formats!.imageJpeg?? '',
        width: width * 0.2,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => SizedBox(
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
